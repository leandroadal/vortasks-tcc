import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/social/group_task_controller.dart';
import 'package:vortasks/models/social/grouptask.dart';

part 'group_task_store.g.dart';

class GroupTaskStore = GroupTaskStoreBase with _$GroupTaskStore;

abstract class GroupTaskStoreBase with Store {
  GroupTaskStoreBase() {
    loadGroupTasks();
  }

  @observable
  ObservableList<GroupTask> groupTasks = ObservableList<GroupTask>();

  @observable
  String? error;

  @observable
  bool isLoading = false;

  @action
  void setGroupTasks(List<GroupTask> tasks) {
    groupTasks.clear();
    groupTasks.addAll(tasks);
  }

  @action
  void setError(String? value) => error = value;

  @action
  void setLoading(bool value) => isLoading = value;

  Future<void> loadGroupTasks() async {
    setError(null);
    setLoading(true);
    try {
      final tasks = await GroupTaskController().getGroupTasks();
      setGroupTasks(tasks);
    } catch (e) {
      setError('Erro ao carregar tarefas em grupo: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }
}
