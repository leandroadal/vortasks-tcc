import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/social/friendship.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_store.dart';

class FriendController {
  final baseEndpoint = '/social/friends';
  final UserStore _userStore = GetIt.I<UserStore>();

  Future<List<Friendship>> getFriends() async {
    final response = await ApiService().get(baseEndpoint);

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body) as List;
      return json.map((e) => Friendship.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      GetIt.I<UserStore>().setUser(null);
      GetIt.I<UserStore>().setToken(null);
      throw BadTokenException('Token inválido');
    }
    throw Exception('Erro ao obter a lista de amigos: ${response.statusCode}');
  }

  Future<void> sendFriendRequest(String username) async {
    final fullURL = '$baseEndpoint/invite/${_userStore.user?.id}/$username';
    final response = await ApiService().post(fullURL, {'username': username});

    if (response.statusCode == 200) {
    } else if (response.statusCode == 403) {
      GetIt.I<UserStore>().setUser(null);
      GetIt.I<UserStore>().setToken(null);
      throw BadTokenException('Token inválido');
    } else {
      throw Exception(
          'Erro ao enviar solicitação de amizade: ${response.statusCode}');
    }
  }

  Future<void> removeFriend(String friendshipId) async {
    final response = await ApiService().delete('$baseEndpoint/$friendshipId');

    if (response.statusCode == 204) {
    } else if (response.statusCode == 403) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json['error'] == 'Token inválido') {
        GetIt.I<UserStore>().setUser(null);
        GetIt.I<UserStore>().setToken(null);
        throw BadTokenException('Token inválido');
      }
    }
    throw Exception('Erro ao remover amigo: ${response.statusCode}');
  }
}
