// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendRequestStore on FriendRequestStoreBase, Store {
  late final _$receivedRequestsAtom =
      Atom(name: 'FriendRequestStoreBase.receivedRequests', context: context);

  @override
  ObservableList<FriendInvite> get receivedRequests {
    _$receivedRequestsAtom.reportRead();
    return super.receivedRequests;
  }

  @override
  set receivedRequests(ObservableList<FriendInvite> value) {
    _$receivedRequestsAtom.reportWrite(value, super.receivedRequests, () {
      super.receivedRequests = value;
    });
  }

  late final _$sentRequestsAtom =
      Atom(name: 'FriendRequestStoreBase.sentRequests', context: context);

  @override
  ObservableList<FriendInvite> get sentRequests {
    _$sentRequestsAtom.reportRead();
    return super.sentRequests;
  }

  @override
  set sentRequests(ObservableList<FriendInvite> value) {
    _$sentRequestsAtom.reportWrite(value, super.sentRequests, () {
      super.sentRequests = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'FriendRequestStoreBase.error', context: context);

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
      Atom(name: 'FriendRequestStoreBase.isLoading', context: context);

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

  late final _$usernamesAtom =
      Atom(name: 'FriendRequestStoreBase.usernames', context: context);

  @override
  ObservableMap<String, String> get usernames {
    _$usernamesAtom.reportRead();
    return super.usernames;
  }

  @override
  set usernames(ObservableMap<String, String> value) {
    _$usernamesAtom.reportWrite(value, super.usernames, () {
      super.usernames = value;
    });
  }

  late final _$fetchUsernameAsyncAction =
      AsyncAction('FriendRequestStoreBase.fetchUsername', context: context);

  @override
  Future<void> fetchUsername(String userId) {
    return _$fetchUsernameAsyncAction.run(() => super.fetchUsername(userId));
  }

  late final _$FriendRequestStoreBaseActionController =
      ActionController(name: 'FriendRequestStoreBase', context: context);

  @override
  void setReceivedRequests(List<FriendInvite> requests) {
    final _$actionInfo = _$FriendRequestStoreBaseActionController.startAction(
        name: 'FriendRequestStoreBase.setReceivedRequests');
    try {
      return super.setReceivedRequests(requests);
    } finally {
      _$FriendRequestStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSentRequests(List<FriendInvite> requests) {
    final _$actionInfo = _$FriendRequestStoreBaseActionController.startAction(
        name: 'FriendRequestStoreBase.setSentRequests');
    try {
      return super.setSentRequests(requests);
    } finally {
      _$FriendRequestStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$FriendRequestStoreBaseActionController.startAction(
        name: 'FriendRequestStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$FriendRequestStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$FriendRequestStoreBaseActionController.startAction(
        name: 'FriendRequestStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$FriendRequestStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
receivedRequests: ${receivedRequests},
sentRequests: ${sentRequests},
error: ${error},
isLoading: ${isLoading},
usernames: ${usernames}
    ''';
  }
}
