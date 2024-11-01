// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LogoutStore on LogoutStoreBase, Store {
  late final _$logoutErrorAtom =
      Atom(name: 'LogoutStoreBase.logoutError', context: context);

  @override
  String? get logoutError {
    _$logoutErrorAtom.reportRead();
    return super.logoutError;
  }

  @override
  set logoutError(String? value) {
    _$logoutErrorAtom.reportWrite(value, super.logoutError, () {
      super.logoutError = value;
    });
  }

  late final _$logoutUserAsyncAction =
      AsyncAction('LogoutStoreBase.logoutUser', context: context);

  @override
  Future<void> logoutUser() {
    return _$logoutUserAsyncAction.run(() => super.logoutUser());
  }

  late final _$LogoutStoreBaseActionController =
      ActionController(name: 'LogoutStoreBase', context: context);

  @override
  void setLogoutError(String? value) {
    final _$actionInfo = _$LogoutStoreBaseActionController.startAction(
        name: 'LogoutStoreBase.setLogoutError');
    try {
      return super.setLogoutError(value);
    } finally {
      _$LogoutStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$LogoutStoreBaseActionController.startAction(
        name: 'LogoutStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$LogoutStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
logoutError: ${logoutError}
    ''';
  }
}
