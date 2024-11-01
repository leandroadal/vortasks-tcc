// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendStore on FriendStoreBase, Store {
  late final _$friendshipsAtom =
      Atom(name: 'FriendStoreBase.friendships', context: context);

  @override
  ObservableList<Friendship> get friendships {
    _$friendshipsAtom.reportRead();
    return super.friendships;
  }

  @override
  set friendships(ObservableList<Friendship> value) {
    _$friendshipsAtom.reportWrite(value, super.friendships, () {
      super.friendships = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'FriendStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'FriendStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$FriendStoreBaseActionController =
      ActionController(name: 'FriendStoreBase', context: context);

  @override
  void setFriendships(List<Friendship> friendships) {
    final _$actionInfo = _$FriendStoreBaseActionController.startAction(
        name: 'FriendStoreBase.setFriendships');
    try {
      return super.setFriendships(friendships);
    } finally {
      _$FriendStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$FriendStoreBaseActionController.startAction(
        name: 'FriendStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$FriendStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
friendships: ${friendships},
error: ${error},
isLoading: ${isLoading}
    ''';
  }
}
