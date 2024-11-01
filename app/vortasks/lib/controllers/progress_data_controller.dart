import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/exceptions/conflict_exception.dart';
import 'package:vortasks/models/user/progress_data.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_data/level_store.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
import 'package:vortasks/stores/shop/sell_store.dart';
import 'package:vortasks/stores/user_store.dart';

class ProgressDataController {
  final baseEndpoint = '/user/progress';
  final SellStore _sellStore = GetIt.I<SellStore>();
  final LevelStore _levelStore = GetIt.I<LevelStore>();
  final ProgressStore _progressStore = GetIt.I<ProgressStore>();

  Future<void> latestProgress(DateTime? lastModified) async {
    try {
      final queryParams = {
        'lastModified': lastModified?.toIso8601String() ?? '',
      };
      final response = await ApiService().get(
        '$baseEndpoint/latest',
        queryParams,
      );

      if (response.body.isNotEmpty) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (await _handleApiResponse(response, json)) {
          _updateProgressFromResponse(json);
        }
      } else {
        await _handle304Conflict();
      }
    } catch (e) {
      rethrow; // Propaga a exceção para ser tratada no ProgressStore
    }
  }

  Future<void> getLatestRemote(DateTime? lastModified) async {
    try {
      final response = await ApiService().get('$baseEndpoint/latest', {
        'lastModified': lastModified?.toIso8601String() ?? '',
      });
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (await _handleApiResponse(response, json)) {
          _updateProgressFromResponse(json);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRemote() async {
    try {
      final response = await ApiService()
          .put(baseEndpoint, _progressStore.progress.toJson());

      final Map<String, dynamic> json = jsonDecode(response.body);

      if (response.statusCode != 200) {
        if (json['error'] == 'Token inválido') {
          GetIt.I<UserStore>().setUser(null);
          GetIt.I<UserStore>().setToken(null);
        } else {
          throw Exception(
              'Erro ao sincronizar dados de progresso: ${response.statusCode}');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forceLocalData() async {
    try {
      final xp = _levelStore.xp;
      final level = _levelStore.currentLevel;
      final coins = _sellStore.coins;
      final gems = _sellStore.gems;
      final last = _progressStore.lastModified;

      final response = await ApiService().put(baseEndpoint, {
        'xp': xp,
        'level': level,
        'coins': coins,
        'gems': gems,
        'lastModified':
            last?.toIso8601String() ?? DateTime.now().toUtc().toIso8601String(),
      });
      //TODO: erros
      if (response.statusCode != 200) {
        throw Exception(
            'Erro ao sincronizar dados de progresso: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  void _updateProgressFromResponse(Map<String, dynamic> json) {
    _progressStore.updateProgress(ProgressData.fromJson(json));
    _progressStore.setLastModified(DateTime.parse(json['lastModified']));
  }

  Future<bool> _handleApiResponse(
      dynamic response, Map<String, dynamic> json) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
      case 400:
        _handle400Error(json);
        break;
      case 403:
        _handle403Error(json);
        break;
      default:
        throw Exception(
            'Erro ao sincronizar dados de progresso: ${response.statusCode}');
    }
    return false;
  }

  Future<void> _handle304Conflict() async {
    final response = await ApiService().get(baseEndpoint);
    final Map<String, dynamic> json = jsonDecode(response.body);

    final localProgress = _progressStore.progress;
    final remoteProgress = ProgressData.fromJson(json);

    if (!areProgressDataEqual(localProgress, remoteProgress)) {
      _progressStore.setLocalProgress(localProgress);
      _progressStore.setRemoteProgress(remoteProgress);
      throw ConflictException(
          'Há um conflito entre seus dados locais e os dados do servidor.');
    }
  }

  bool areProgressDataEqual(ProgressData? local, ProgressData? remote) {
    if (local == null || remote == null) {
      return false;
    }

    return local.xp == remote.xp &&
        local.level == remote.level &&
        local.coins == remote.coins &&
        local.gems == remote.gems &&
        local.lastModified == remote.lastModified;
  }

  void _handle400Error(Map<String, dynamic> json) {
    // Erros de validação
    if (json['error'] == 'Erro ao validar o argumento') {
      final List errors = json['errors'];

      String errorMessage = '';
      for (var error in errors) {
        errorMessage += '\n\nErro: ${error['message']}';
      }
      errorMessage += '\n\n';

      throw Exception('Erro na validação dos dados: $errorMessage');
    } else {
      throw Exception(json['message']);
    }
  }

  void _handle403Error(Map<String, dynamic> json) {
    if (json['error'] == 'Token inválido') {
      GetIt.I<UserStore>().setUser(null);
      GetIt.I<UserStore>().setToken(null);
      throw BadTokenException('Token inválido');
    }
  }
}
