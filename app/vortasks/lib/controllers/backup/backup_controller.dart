import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/models/backup/backup.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/backup/backup_store.dart';
import 'package:vortasks/stores/user_store.dart';

class BackupController {
  final baseEndpoint = '/user/backup';
  final BackupStore _backupStore = GetIt.I<BackupStore>();

  Future<void> getBackupAfterLogin() async {
    final response = await ApiService().get(baseEndpoint);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(utf8.decode(response.bodyBytes));

      final localBackup = _backupStore.latestBackupData;
      final remoteBackup = Backup.fromJson(json);
      _backupStore.setLocalBackup(localBackup);
      _backupStore.setRemoteBackup(remoteBackup);

      // Indica um conflito de dados locais e os dados do servidor.
      _backupStore.setHasConflict(true);
    } else if (response.statusCode == 403) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json['error'] == 'Token inválido') {
        GetIt.I<UserStore>().setUser(null);
        GetIt.I<UserStore>().setToken(null);
      }
    } else if (response.statusCode == 404) {
      _backupStore.setError('Não existe backup no servidor');
    } else {
      _backupStore.setError('Erro ao sincronizar backup');
    }
  }

  Future<bool> createBackup() async {
    final response = await ApiService().post(
      '/user/backup/create',
      _backupStore.latestBackupData.toJson(),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(utf8.decode(response.bodyBytes));
      _backupStore.setBackup(Backup.fromJson(json));
      return true;
    } else if (response.statusCode == 400) {
      _backupStore.setError('Já existe um backup');
    } else if (response.statusCode == 403) {
      GetIt.I<UserStore>().setUser(null);
      GetIt.I<UserStore>().setToken(null);
      _backupStore.setError('Entre em sua conta para sincronizar backup');
    } else {
      _backupStore.setError('Erro ao sincronizar backup');
    }
    return false;
  }

  Future<bool> updateBackup() async {
    final response = await ApiService().put(
      baseEndpoint,
      _backupStore.latestBackupData.toJson(),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(utf8.decode(response.bodyBytes));
      _backupStore.setBackup(Backup.fromJson(json));
      return true;
      //_saveBackup();
    } else if (response.statusCode == 403) {
      GetIt.I<UserStore>().setUser(null);
      GetIt.I<UserStore>().setToken(null);
      _backupStore.setError('Entre em sua conta para sincronizar backup');
      return false;
    } else if (response.statusCode == 404) {
      _backupStore.setError('Backup não encontrado');
    } else {
      _backupStore.setError('Erro ao sincronizar backup');
    }
    return false;
  }
}
