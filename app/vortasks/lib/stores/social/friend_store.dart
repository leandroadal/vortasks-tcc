import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/social/friend_controller.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/social/friendship.dart';

part 'friend_store.g.dart';

class FriendStore = FriendStoreBase with _$FriendStore;

abstract class FriendStoreBase with Store {
  FriendStoreBase() {
    loadFriends();
  }

  @observable
  ObservableList<Friendship> friendships = ObservableList<Friendship>();

  @observable
  String? error;

  @observable
  bool isLoading = false;

  @action
  void setFriendships(List<Friendship> friendships) {
    this.friendships.clear();
    this.friendships.addAll(friendships);
  }

  @action
  void setError(String? value) => error = value;

  Future<void> loadFriends() async {
    try {
      error = null;
      final friendsData = await FriendController().getFriends();
      setFriendships(friendsData);
    } on BadTokenException catch (_) {
      setError('Token Inválido');
    } catch (e) {
      setError('Erro ao carregar a lista de amigos');
    }
  }

  Future<bool> addFriend(String username) async {
    try {
      error = null;
      await FriendController().sendFriendRequest(username);
      await loadFriends(); // Recarrega a lista de amigos
      return true; // Retorna true para indicar sucesso
    } on BadTokenException catch (_) {
      setError('Token inválido');
      return false;
    } catch (e) {
      setError('Erro ao adicionar amigo');
      return false;
    }
  }

  Future<void> removeFriend(String friendshipId) async {
    try {
      error = null;
      await FriendController().removeFriend(friendshipId);
      await loadFriends(); // Recarrega a lista de amigos
    } on BadTokenException catch (_) {
      setError('Token inválido');
    } catch (e) {
      setError('Erro ao remover amigo');
    }
  }
}
