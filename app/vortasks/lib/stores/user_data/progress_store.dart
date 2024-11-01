import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/progress_data_controller.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/exceptions/conflict_exception.dart';
import 'package:vortasks/exceptions/not_sign_exception.dart';
import 'package:vortasks/exceptions/sync_exception.dart';
import 'package:vortasks/models/user/progress_data.dart';
import 'package:vortasks/stores/user_data/level_store.dart';
import 'package:vortasks/stores/shop/sell_store.dart';
import 'package:vortasks/stores/user_store.dart';

part 'progress_store.g.dart';

class ProgressStore = ProgressStoreBase with _$ProgressStore;

abstract class ProgressStoreBase with Store {
  ProgressStoreBase() {
    _loadLastModified();
  }

  final LevelStore levelStore = GetIt.I<LevelStore>();
  final SellStore sellStore = GetIt.I<SellStore>();
  final UserStore _userStore = GetIt.I<UserStore>();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  DateTime? lastModified;

  @action
  void setLastModified(DateTime lastModified) {
    this.lastModified = lastModified;
    _saveLastModified();
  }

  @computed
  ProgressData get progress => ProgressData(
        xp: levelStore.xp,
        level: levelStore.currentLevel,
        coins: sellStore.coins,
        gems: sellStore.gems,
        lastModified: lastModified,
      );

  void updateProgress(ProgressData progress) {
    levelStore.setCurrentLevel(progress.level);
    levelStore.setXP(progress.xp);
    sellStore.setCoins(progress.coins);
    sellStore.setGems(progress.gems);
    setLastModified(progress.lastModified ?? DateTime.now().toUtc());
  }

  @observable
  ProgressData? localProgress;

  @observable
  ProgressData? remoteProgress;

  @action
  void setLocalProgress(ProgressData? progress) => localProgress = progress;

  @action
  void setRemoteProgress(ProgressData? progress) => remoteProgress = progress;

  @action
  Future<void> resolveConflictWithRemote() async {
    //await ProgressDataController().forceRemoteData();
    updateProgress(remoteProgress!);
    hasConflict = false;
    localProgress = null;
    remoteProgress = null;
  }

  @action
  Future<void> resolveConflictWithLocal() async {
    await ProgressDataController().forceLocalData();
    hasConflict = false;
    localProgress = null;
    remoteProgress = null;
  }

  @observable
  bool hasConflict = false;

  @action
  void setHasConflict(bool value) => hasConflict = value;

  void _saveLastModified() {
    LocalStorage.saveData('lastModified', lastModified?.toIso8601String());
  }

  void _loadLastModified() {
    final lastModifiedStr = LocalStorage.getString('lastModified');
    if (lastModifiedStr != null) {
      lastModified = DateTime.parse(lastModifiedStr);
    }
  }

  @action
  Future<void> syncAfterLogin() async {
    setLoading(true);
    try {
      if (_userStore.isLoggedIn && lastModified != null) {
        await ProgressDataController().latestProgress(lastModified);
      } else {
        await ProgressDataController().getLatestRemote(lastModified);
      }
    } catch (e) {
      log('Erro na sincronização: $e');
      if (e is ConflictException) {
        setHasConflict(true);
      } else {
        throw SyncException();
      }
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> syncAfterRegister() async {
    try {
      lastModified ??= DateTime.now().toUtc();
      await GetIt.I<ProgressStore>().toRemote();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> toRemote() async {
    setLoading(true);
    try {
      if (_userStore.isLoggedIn) {
        await ProgressDataController().updateRemote();
      } else {
        throw NotSignException('Não é possível sincronizar sem fazer login');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> fromRemote() async {
    setLoading(true);
    try {
      if (_userStore.isLoggedIn) {
        await ProgressDataController().getLatestRemote(lastModified);
      } else {
        throw NotSignException('Não é possível sincronizar sem fazer login');
      }
    } on BadTokenException catch (_) {
      // Acontece quando o token expira
      rethrow;
    } on NotSignException catch (_) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
