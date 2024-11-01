import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/invalid_credentials_exception.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/auth/login_store.dart';
import 'package:vortasks/stores/auth/logout_store.dart';
import 'package:vortasks/stores/auth/signup_store.dart';
import 'package:vortasks/stores/user_store.dart';

class AuthController {
  final baseEndpoint = '/auth';
  final LoginStore _loginStore = GetIt.I<LoginStore>();
  final UserStore _userStore = GetIt.I<UserStore>();
  final SignUpStore _signUpStore = GetIt.I<SignUpStore>();

  Future<void> register(Map<String, dynamic> data) async {
    try {
      final response = await ApiService().post('$baseEndpoint/register', data);
      final Map<String, dynamic> json = jsonDecode(response.body);

      _handleApiResponse(response, json, store: _signUpStore);
    } on BadCredentialsException catch (_) {
      rethrow;
    } catch (e) {
      _signUpStore.setError('Erro ao registrar usuário');
    }
  }

  Future<bool> login(Map<String, dynamic> data) async {
    try {
      final response = await ApiService().post('$baseEndpoint/login', data);
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        if (_handleApiResponse(response, json, store: _loginStore)) {
          _userStore.setToken(json['token']);
          return true;
        }
      } else if (response.statusCode == 403) {
        _loginStore.setError('Usuário invalido');
        return false;
      }
      return false;
    } on BadCredentialsException catch (_) {
      rethrow;
    } catch (e) {
      _loginStore.setError('Erro ao fazer login');
      return false;
    }
  }

  Future<void> logout() async {
    final response = await ApiService().post('$baseEndpoint/logout', {});

    if (response.statusCode == 403) {
      _userStore.setToken(null);
      _userStore.setUser(null);
    } else if (response.statusCode != 200) {
      GetIt.I<LogoutStore>().setLogoutError('Erro ao fazer logout');
    }
  }

  bool _handleApiResponse(dynamic response, Map<String, dynamic> json,
      {required dynamic store}) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
      case 400:
        _handle400Error(json, store: store);
        break;
      case 401:
        if (store is LoginStore) _handleLogin401Error(json);
        break;
      case 403:
        if (json['error'] == 'Token inválido') {
          _userStore.setToken(null);
          _userStore.setUser(null);
          store.setError('Erro ao processar a requisição');
        } else {}
      case 404:
        store.setError(json['message']);
        break;
      default:
        store.setError('Erro ao processar a requisição');
    }
    return false;
  }

  void _handleLogin401Error(Map<String, dynamic> json) {
    if (json['message'].toString().contains('Username')) {
      _loginStore.setError('Usuário invalido');
    } else {
      _loginStore.setError('Senha invalida');
    }
    throw BadCredentialsException('Credenciais invalidas');
  }

  void _handle400Error(Map<String, dynamic> json, {required dynamic store}) {
    if (json['error'] == 'Erro ao validar o argumento') {
      final List errors = json['errors'];

      String errorMessage = '';
      for (var error in errors) {
        errorMessage += '\n\nErro: ${error['message']}';
      }
      errorMessage += '\n\n';

      store.setError(errorMessage);
    } else {
      store.setError(json['message']);
    }
  }
}
