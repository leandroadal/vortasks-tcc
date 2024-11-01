import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/social/group_subtask.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_store.dart';

class GroupSubtaskController {
  final baseEndpoint = '/social/groupTasks';

  Future<void> editGroupSubtask(
      String groupTaskId, String subtaskId, GroupSubtask subtask) async {
    final response = await ApiService().put(
      '$baseEndpoint/$groupTaskId/tasks/$subtaskId',
      subtask.toJson(),
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para editar a Sub Tarefa');
    }
    throw Exception(
        'Erro ao editar uma sub tarefa em grupo: ${response.statusCode}');
  }
}
