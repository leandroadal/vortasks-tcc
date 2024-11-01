// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_task_invite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GroupTaskInviteStore on GroupTaskInviteStoreBase, Store {
  late final _$invitesAtom =
      Atom(name: 'GroupTaskInviteStoreBase.invites', context: context);

  @override
  ObservableList<GroupTaskInvite> get invites {
    _$invitesAtom.reportRead();
    return super.invites;
  }

  @override
  set invites(ObservableList<GroupTaskInvite> value) {
    _$invitesAtom.reportWrite(value, super.invites, () {
      super.invites = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'GroupTaskInviteStoreBase.error', context: context);

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
      Atom(name: 'GroupTaskInviteStoreBase.isLoading', context: context);

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

  late final _$GroupTaskInviteStoreBaseActionController =
      ActionController(name: 'GroupTaskInviteStoreBase', context: context);

  @override
  void setInvites(List<GroupTaskInvite> newInvites) {
    final _$actionInfo = _$GroupTaskInviteStoreBaseActionController.startAction(
        name: 'GroupTaskInviteStoreBase.setInvites');
    try {
      return super.setInvites(newInvites);
    } finally {
      _$GroupTaskInviteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$GroupTaskInviteStoreBaseActionController.startAction(
        name: 'GroupTaskInviteStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$GroupTaskInviteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$GroupTaskInviteStoreBaseActionController.startAction(
        name: 'GroupTaskInviteStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$GroupTaskInviteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
invites: ${invites},
error: ${error},
isLoading: ${isLoading}
    ''';
  }
}
