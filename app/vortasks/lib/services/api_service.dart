import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:vortasks/stores/user_store.dart';

class ApiService {
  final String baseUrl = Platform.isAndroid
      ? (Platform.environment.containsKey('ANDROID_EMULATOR')
          ? const String.fromEnvironment('API_BASE_URL',
              defaultValue: 'http://10.0.2.2:8080') // Emulador Android
          : const String.fromEnvironment('API_BASE_URL',
              defaultValue:
                  'http://192.168.0.113:8080')) // Dispositivo Físico (use o IP local correto)
      : const String.fromEnvironment('API_BASE_URL',
          defaultValue: 'http://localhost:8080');
  final UserStore _userStore = GetIt.I<UserStore>();

  Future<http.Response> get(String endpoint,
      [Map<String, String?>? queryParameters]) async {
    String? token = _userStore.token;

    // Verifica se o token está definido antes de enviar a solicitação
    if (token != null) {
      return queryParameters == null
          ? await http.get(
              Uri.parse('$baseUrl$endpoint'),
              headers: {'Authorization': 'Bearer $token'},
            )
          : await http.get(
              Uri.parse('$baseUrl$endpoint')
                  .replace(queryParameters: queryParameters),
              headers: {'Authorization': 'Bearer $token'},
            );
    } else {
      // Se o token não estiver definido, envia a solicitação sem o cabeçalho de autorização
      return await http.get(Uri.parse('$baseUrl$endpoint'));
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    String? token = _userStore.token;
    final headers = {
      'Content-Type':
          'application/json', // Definindo o tipo de conteúdo como JSON
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body), // Convertendo o corpo para JSON
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    String? token = _userStore.token;
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<http.Response> patch(
      String endpoint, Map<String, dynamic> body) async {
    String? token = _userStore.token;
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<http.Response> delete(String endpoint) async {
    String? token = _userStore.token;
    if (token != null) {
      return await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Authorization': 'Bearer $token'},
      );
    } else {
      return await http.delete(Uri.parse('$baseUrl$endpoint'));
    }
  }
}
