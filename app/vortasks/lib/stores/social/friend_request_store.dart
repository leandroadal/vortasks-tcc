import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/social/friend_request_controller.dart';
import 'package:vortasks/controllers/user_controller.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/social/friend_invite.dart';
import 'package:vortasks/stores/user_store.dart'; // Importe o novo modelo

part 'friend_request_store.g.dart';

class FriendRequestStore = FriendRequestStoreBase with _$FriendRequestStore;

abstract class FriendRequestStoreBase with Store {
  @observable
  ObservableList<FriendInvite> receivedRequests =
      ObservableList<FriendInvite>();

  @observable
  ObservableList<FriendInvite> sentRequests = ObservableList<FriendInvite>();

  @observable
  String? error;

  @observable
  bool isLoading = false;

  @observable
  ObservableMap<String, String> usernames = ObservableMap<String, String>();

  @action
  void setReceivedRequests(List<FriendInvite> requests) {
    receivedRequests.clear();
    receivedRequests.addAll(requests);
  }

  @action
  void setSentRequests(List<FriendInvite> requests) {
    sentRequests.clear();
    sentRequests.addAll(requests);
  }

  @action
  void setError(String? value) => error = value;

  @action
  void setLoading(bool value) => isLoading = value;

  Future<void> loadFriendRequests() async {
    try {
      setError(null);
      setLoading(true);
      final requests = await FriendRequestController().getFriendRequests();
      final userStore = GetIt.I<UserStore>();
      // Separa as solicitações recebidas das enviadas
      setReceivedRequests(requests
          .where((request) => request.receiverId == userStore.user?.id)
          .toList());
      setSentRequests(requests
          .where((request) => request.senderId == userStore.user?.id)
          .toList());
    } on BadTokenException catch (_) {
      setError('Token inválido');
    } catch (e) {
      setError('Erro ao carregar solicitações de amizade');
    } finally {
      setLoading(false);
    }
  }

  Future<void> acceptFriendRequest(String senderId) async {
    try {
      setError(null);
      setLoading(true);
      await FriendRequestController().acceptFriendRequest(senderId);
      await loadFriendRequests();
    } catch (e) {
      setError('Erro ao aceitar solicitação de amizade');
    } finally {
      setLoading(false);
    }
  }

  Future<void> rejectFriendRequest(String senderId) async {
    try {
      setError(null);
      setLoading(true);
      await FriendRequestController().rejectFriendRequest(senderId);
      await loadFriendRequests();
    } catch (e) {
      setError('Erro ao rejeitar solicitação de amizade');
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> fetchUsername(String userId) async {
    if (!usernames.containsKey(userId)) {
      // Verifica se o nome já está no mapa
      try {
        final username = await UserController().getUsernameById(userId);
        usernames[userId] = username;
      } catch (e) {
        usernames[userId] =
            'Erro ao carregar nome'; // Valor padrão em caso de erro
      }
    }
  }
}
