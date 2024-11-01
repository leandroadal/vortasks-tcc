import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/social/group_task_controller.dart';
import 'package:vortasks/models/social/grouptask.dart';

part 'social_store.g.dart';

class SocialStore = SocialStoreBase with _$SocialStore;

abstract class SocialStoreBase with Store {
  @observable
  ObservableList<GroupTask> groupTasks = ObservableList<GroupTask>();

  @observable
  ObservableList<GroupTask> friendMissions = ObservableList<GroupTask>();

  @observable
  ObservableList<GroupTask> todayGroupTasks = ObservableList<GroupTask>();

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

  @action
  Future<void> loadTodayGroupTasks() async {
    setError(null);
    try {
      final tasks = await GroupTaskController().getTodayGroupTasks();
      todayGroupTasks.clear();
      todayGroupTasks.addAll(tasks);
    } catch (e) {
      setError(e.toString());
    }
  }

  @action
  Future<void> loadGroupTaskById(String id) async {
    setError(null);
    setLoading(true);
    try {
      final task = await GroupTaskController().getGroupTaskById(id);
      if (task != null) {
        // Adiciona a tarefa à lista groupTasks se ela ainda não existir
        if (!groupTasks.any((t) => t.id == task.id)) {
          groupTasks.add(task);
        }
      } else {
        setError('Tarefa em grupo não encontrada');
      }
    } catch (e) {
      setError('Erro ao carregar tarefa em grupo: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }
}
