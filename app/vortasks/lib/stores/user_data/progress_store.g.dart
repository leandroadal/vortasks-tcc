// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProgressStore on ProgressStoreBase, Store {
  Computed<ProgressData>? _$progressComputed;

  @override
  ProgressData get progress =>
      (_$progressComputed ??= Computed<ProgressData>(() => super.progress,
              name: 'ProgressStoreBase.progress'))
          .value;

  late final _$loadingAtom =
      Atom(name: 'ProgressStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$lastModifiedAtom =
      Atom(name: 'ProgressStoreBase.lastModified', context: context);

  @override
  DateTime? get lastModified {
    _$lastModifiedAtom.reportRead();
    return super.lastModified;
  }

  @override
  set lastModified(DateTime? value) {
    _$lastModifiedAtom.reportWrite(value, super.lastModified, () {
      super.lastModified = value;
    });
  }

  late final _$localProgressAtom =
      Atom(name: 'ProgressStoreBase.localProgress', context: context);

  @override
  ProgressData? get localProgress {
    _$localProgressAtom.reportRead();
    return super.localProgress;
  }

  @override
  set localProgress(ProgressData? value) {
    _$localProgressAtom.reportWrite(value, super.localProgress, () {
      super.localProgress = value;
    });
  }

  late final _$remoteProgressAtom =
      Atom(name: 'ProgressStoreBase.remoteProgress', context: context);

  @override
  ProgressData? get remoteProgress {
    _$remoteProgressAtom.reportRead();
    return super.remoteProgress;
  }

  @override
  set remoteProgress(ProgressData? value) {
    _$remoteProgressAtom.reportWrite(value, super.remoteProgress, () {
      super.remoteProgress = value;
    });
  }

  late final _$hasConflictAtom =
      Atom(name: 'ProgressStoreBase.hasConflict', context: context);

  @override
  bool get hasConflict {
    _$hasConflictAtom.reportRead();
    return super.hasConflict;
  }

  @override
  set hasConflict(bool value) {
    _$hasConflictAtom.reportWrite(value, super.hasConflict, () {
      super.hasConflict = value;
    });
  }

  late final _$resolveConflictWithRemoteAsyncAction = AsyncAction(
      'ProgressStoreBase.resolveConflictWithRemote',
      context: context);

  @override
  Future<void> resolveConflictWithRemote() {
    return _$resolveConflictWithRemoteAsyncAction
        .run(() => super.resolveConflictWithRemote());
  }

  late final _$resolveConflictWithLocalAsyncAction = AsyncAction(
      'ProgressStoreBase.resolveConflictWithLocal',
      context: context);

  @override
  Future<void> resolveConflictWithLocal() {
    return _$resolveConflictWithLocalAsyncAction
        .run(() => super.resolveConflictWithLocal());
  }

  late final _$syncAfterLoginAsyncAction =
      AsyncAction('ProgressStoreBase.syncAfterLogin', context: context);

  @override
  Future<void> syncAfterLogin() {
    return _$syncAfterLoginAsyncAction.run(() => super.syncAfterLogin());
  }

  late final _$syncAfterRegisterAsyncAction =
      AsyncAction('ProgressStoreBase.syncAfterRegister', context: context);

  @override
  Future<void> syncAfterRegister() {
    return _$syncAfterRegisterAsyncAction.run(() => super.syncAfterRegister());
  }

  late final _$ProgressStoreBaseActionController =
      ActionController(name: 'ProgressStoreBase', context: context);

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$ProgressStoreBaseActionController.startAction(
        name: 'ProgressStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$ProgressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastModified(DateTime lastModified) {
    final _$actionInfo = _$ProgressStoreBaseActionController.startAction(
        name: 'ProgressStoreBase.setLastModified');
    try {
      return super.setLastModified(lastModified);
    } finally {
      _$ProgressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocalProgress(ProgressData? progress) {
    final _$actionInfo = _$ProgressStoreBaseActionController.startAction(
        name: 'ProgressStoreBase.setLocalProgress');
    try {
      return super.setLocalProgress(progress);
    } finally {
      _$ProgressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRemoteProgress(ProgressData? progress) {
    final _$actionInfo = _$ProgressStoreBaseActionController.startAction(
        name: 'ProgressStoreBase.setRemoteProgress');
    try {
      return super.setRemoteProgress(progress);
    } finally {
      _$ProgressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasConflict(bool value) {
    final _$actionInfo = _$ProgressStoreBaseActionController.startAction(
        name: 'ProgressStoreBase.setHasConflict');
    try {
      return super.setHasConflict(value);
    } finally {
      _$ProgressStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
lastModified: ${lastModified},
localProgress: ${localProgress},
remoteProgress: ${remoteProgress},
hasConflict: ${hasConflict},
progress: ${progress}
    ''';
  }
}
