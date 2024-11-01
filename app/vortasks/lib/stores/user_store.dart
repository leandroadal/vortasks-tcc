import 'package:mobx/mobx.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'dart:convert';

import 'package:vortasks/models/user/user.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  UserStoreBase() {
    _loadUser();
    _loadToken();
  }

  @observable
  User? user;

  @action
  void setUser(User? newUser) {
    user = newUser;
    _saveUser();
  }

  @computed
  bool get isLoggedIn => user != null && token != null;

  @observable
  String? token;

  @action
  void setToken(String? newToken) {
    token = newToken;
    _saveToken();
  }

  @computed
  String? get name => user?.name;

  @computed
  String? get email => user?.email;

  @computed
  String? get username => user?.username;

  // TODO:
  //@computed
  //String? get avatar => user?.avatar;

  // ================ Armazenamento local ================

  // Carregar usuário do armazenamento local
  void _loadUser() {
    final userJson = LocalStorage.getString('user');
    if (userJson != null) {
      user = User.fromJson(json.decode(userJson));
    }
  }

  // Salvar usuário no armazenamento local
  void _saveUser() {
    if (user != null) {
      LocalStorage.saveData('user', json.encode(user!.toJson()));
    } else {
      LocalStorage.deleteKey('user'); // Remove a chave se o usuário for nulo
    }
  }

  void _loadToken() {
    token = LocalStorage.getString('token');
  }

  // Salvar token no armazenamento local
  void _saveToken() {
    LocalStorage.saveData('token', token);
  }
}
