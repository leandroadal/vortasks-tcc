import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/social/grouptask.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_store.dart';

class GroupTaskController {
  final baseEndpoint = '/social/groupTasks';

  Future<List<GroupTask>> getGroupTasks() async {
    final response = await ApiService().get(baseEndpoint);

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body) as List;
      return json.map((e) => GroupTask.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para editar tarefa em grupo');
    } else {
      throw Exception('Erro ao obter tarefas em grupo: ${response.statusCode}');
    }
  }

  Future<GroupTask?> getGroupTaskById(String id) async {
    final response = await ApiService().get('$baseEndpoint/$id');

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(utf8.decode(response.bodyBytes));
      return GroupTask.fromJson(json);
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para aceitar obter a tarefa em grupo');
    }
    throw Exception('Erro ao obter a tarefa em grupo: ${response.statusCode}');
  }

  Future<GroupTask> createGroupTask(GroupTask groupTask) async {
    final response = await ApiService().post(
      baseEndpoint,
      groupTask.toJson(),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> json =
          jsonDecode(utf8.decode(response.bodyBytes));
      return GroupTask.fromJson(json);
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para criar tarefa em grupo');
    }
    throw Exception('Erro ao criar tarefa em grupo: ${response.statusCode}');
  }

  Future<void> editGroupTask(GroupTask groupTask) async {
    final response = await ApiService().put(
      '$baseEndpoint/${groupTask.id}',
      groupTask.toJson(),
    );

    if (response.statusCode == 200) {
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para editar tarefa em grupo');
    } else {
      throw Exception('Erro ao editar tarefa em grupo: ${response.statusCode}');
    }
  }

  Future<void> deleteGroupTask(String groupId) async {
    final response = await ApiService().delete('$baseEndpoint/$groupId');

    if (response.statusCode == 204) {
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para editar tarefa em grupo');
    } else {
      throw Exception(
          'Erro ao excluir tarefa em grupo: ${response.statusCode}');
    }
  }

  Future<List<GroupTask>> getTodayGroupTasks() async {
    final response = await ApiService().get('$baseEndpoint/search', {
      'title': '',
      'endDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.now()),
      'page': '0',
      'linesPerPage': '10',
      'direction': 'ASC',
      'orderBy': 'createdAt',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> content = json['content'] as List;
      final tasks = content.map((e) => GroupTask.fromJson(e)).toList();
      return tasks;
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para obter as tarefa em grupo');
    } else {
      throw Exception(
          'Erro ao obter tarefas em grupo do dia: ${response.statusCode}');
    }
  }
}
