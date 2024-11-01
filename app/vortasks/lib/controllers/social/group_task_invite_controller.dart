import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/social/group_task_invite.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_store.dart';

class GroupTaskInviteController {
  final baseEndpoint = '/social/groupTasks/invites';
  final UserStore _userStore = GetIt.I<UserStore>();

  Future<List<GroupTaskInvite>> getInvites() async {
    final response = await ApiService().get(baseEndpoint);

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body) as List;
      return json.map((e) => GroupTaskInvite.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      if (_userStore.token != null) {
        _userStore.setUser(null);
        _userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para obter os convites');
    } else {
      throw Exception('Erro ao obter convites: ${response.statusCode}');
    }
  }

  Future<List<GroupTaskInvite>> getInvitesByGroupTask(
      String groupTaskId) async {
    final response = await ApiService().get('$baseEndpoint/task/$groupTaskId');

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body) as List;
      return json.map((e) => GroupTaskInvite.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      if (_userStore.token != null) {
        _userStore.setUser(null);
        _userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para obter os convites');
    } else {
      throw Exception(
          'Erro ao obter convites da tarefa: ${response.statusCode}');
    }
  }

  Future<void> acceptInvite(String inviteId) async {
    final response =
        await ApiService().put('$baseEndpoint/$inviteId/accept', {});

    if (response.statusCode == 200) {
    } else if (response.statusCode == 403) {
      if (_userStore.token != null) {
        _userStore.setUser(null);
        _userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para aceitar os convites');
    } else {
      throw Exception('Erro ao aceitar convite: ${response.statusCode}');
    }
  }

  Future<void> rejectInvite(String inviteId) async {
    final response =
        await ApiService().put('$baseEndpoint/$inviteId/reject', {});

    if (response.statusCode == 200) {
    } else if (response.statusCode == 403) {
      if (_userStore.token != null) {
        _userStore.setUser(null);
        _userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para rejeitar os convites');
    } else {
      throw Exception('Erro ao rejeitar convite: ${response.statusCode}');
    }
  }

  Future<List<GroupTaskInvite>> createInvites(
      String groupTaskId, List<String> usernames) async {
    final response = await ApiService().post('$baseEndpoint/$groupTaskId', {
      'usernames': usernames,
    });

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body) as List;
      return json.map((e) => GroupTaskInvite.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      if (_userStore.token != null) {
        _userStore.setUser(null);
        _userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para rejeitar os convites');
    } else {
      throw Exception('Erro ao criar convites: ${response.statusCode}');
    }
  }
}
