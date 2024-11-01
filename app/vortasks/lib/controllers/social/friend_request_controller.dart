import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/social/friend_invite.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_store.dart';

class FriendRequestController {
  final baseEndpoint = '/social/friends/invite';

  Future<List<FriendInvite>> getFriendRequests() async {
    final response = await ApiService().get(baseEndpoint);

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body) as List;
      return json.map((e) => FriendInvite.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      GetIt.I<UserStore>().setUser(null);
      GetIt.I<UserStore>().setToken(null);
      throw BadTokenException('Token inválido');
    } else {
      throw Exception(
          'Erro ao obter solicitações de amizade: ${response.statusCode}');
    }
  }

  Future<void> acceptFriendRequest(String senderId) async {
    final userStore = GetIt.I<UserStore>();

    final response = await ApiService()
        .post('$baseEndpoint/accept/$senderId/${userStore.user?.id}', {});

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para aceitar a solicitação de amizade');
    }
    throw Exception(
        'Erro ao aceitar solicitação de amizade: ${response.statusCode}');
  }

  Future<void> rejectFriendRequest(String senderId) async {
    final userStore = GetIt.I<UserStore>();
    final response = await ApiService()
        .put('$baseEndpoint/refuse/$senderId/${userStore.user?.id}', {});

    if (response.statusCode != 204) {
      throw Exception(
          'Erro ao rejeitar solicitação de amizade: ${response.statusCode}');
    }
  }
}
