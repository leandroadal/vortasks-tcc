import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/user_info_exception.dart';
import 'package:vortasks/models/user/user.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_store.dart';

class UserController {
  final baseEndpoint = '/user';
  final UserStore _userStore = GetIt.I<UserStore>();

  Future<void> userInfo() async {
    final response = await ApiService().get(baseEndpoint);

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _userStore.setUser(User.fromJson(json));
    } else {
      _userStore.setToken(null);
      _userStore.setUser(null);
      throw UserInfoException('Erro ao obter o usuário através da API');
    }
  }

  Future<String> getUsernameById(String userId) async {
    try {
      final response = await ApiService().get('/user/$userId');

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(
            'Erro ao obter nome de usuário: ${response.statusCode}');
      }
    } catch (e) {
      return 'Usuário não encontrado';
    }
  }
}
