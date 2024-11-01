import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/social/group_task_invite_controller.dart';
import 'package:vortasks/models/social/group_task_invite.dart';

part 'group_task_invite_store.g.dart';

class GroupTaskInviteStore = GroupTaskInviteStoreBase
    with _$GroupTaskInviteStore;

abstract class GroupTaskInviteStoreBase with Store {
  GroupTaskInviteStoreBase() {
    loadInvites();
  }

  @observable
  ObservableList<GroupTaskInvite> invites = ObservableList<GroupTaskInvite>();

  @observable
  String? error;

  @observable
  bool isLoading = false;

  @action
  void setInvites(List<GroupTaskInvite> newInvites) {
    invites.clear();
    invites.addAll(newInvites);
  }

  @action
  void setError(String? value) => error = value;

  @action
  void setLoading(bool value) => isLoading = value;

  Future<void> loadInvites() async {
    setError(null);
    setLoading(true);
    try {
      final newInvites = await GroupTaskInviteController().getInvites();
      setInvites(newInvites);
    } catch (e) {
      setError('Erro ao carregar convites: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> acceptInvite(String inviteId) async {
    setError(null);
    setLoading(true);
    try {
      await GroupTaskInviteController().acceptInvite(inviteId);
      await loadInvites(); // Recarrega a lista de convites
    } catch (e) {
      setError('Erro ao aceitar convite: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> rejectInvite(String inviteId) async {
    setError(null);
    setLoading(true);
    try {
      await GroupTaskInviteController().rejectInvite(inviteId);
      await loadInvites();
    } catch (e) {
      setError('Erro ao rejeitar convite: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> createInvites(String groupTaskId, List<String> usernames) async {
    setLoading(true);
    setError(null);
    try {
      await GroupTaskInviteController().createInvites(groupTaskId, usernames);
      await loadInvites();
    } catch (e) {
      setError('Erro ao enviar convites: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }
}
