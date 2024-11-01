// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SocialStore on SocialStoreBase, Store {
  late final _$groupTasksAtom =
      Atom(name: 'SocialStoreBase.groupTasks', context: context);

  @override
  ObservableList<GroupTask> get groupTasks {
    _$groupTasksAtom.reportRead();
    return super.groupTasks;
  }

  @override
  set groupTasks(ObservableList<GroupTask> value) {
    _$groupTasksAtom.reportWrite(value, super.groupTasks, () {
      super.groupTasks = value;
    });
  }

  late final _$friendMissionsAtom =
      Atom(name: 'SocialStoreBase.friendMissions', context: context);

  @override
  ObservableList<GroupTask> get friendMissions {
    _$friendMissionsAtom.reportRead();
    return super.friendMissions;
  }

  @override
  set friendMissions(ObservableList<GroupTask> value) {
    _$friendMissionsAtom.reportWrite(value, super.friendMissions, () {
      super.friendMissions = value;
    });
  }

  late final _$todayGroupTasksAtom =
      Atom(name: 'SocialStoreBase.todayGroupTasks', context: context);

  @override
  ObservableList<GroupTask> get todayGroupTasks {
    _$todayGroupTasksAtom.reportRead();
    return super.todayGroupTasks;
  }

  @override
  set todayGroupTasks(ObservableList<GroupTask> value) {
    _$todayGroupTasksAtom.reportWrite(value, super.todayGroupTasks, () {
      super.todayGroupTasks = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'SocialStoreBase.error', context: context);

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
      Atom(name: 'SocialStoreBase.isLoading', context: context);

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

  late final _$loadTodayGroupTasksAsyncAction =
      AsyncAction('SocialStoreBase.loadTodayGroupTasks', context: context);

  @override
  Future<void> loadTodayGroupTasks() {
    return _$loadTodayGroupTasksAsyncAction
        .run(() => super.loadTodayGroupTasks());
  }

  late final _$loadGroupTaskByIdAsyncAction =
      AsyncAction('SocialStoreBase.loadGroupTaskById', context: context);

  @override
  Future<void> loadGroupTaskById(String id) {
    return _$loadGroupTaskByIdAsyncAction
        .run(() => super.loadGroupTaskById(id));
  }

  late final _$SocialStoreBaseActionController =
      ActionController(name: 'SocialStoreBase', context: context);

  @override
  void setGroupTasks(List<GroupTask> tasks) {
    final _$actionInfo = _$SocialStoreBaseActionController.startAction(
        name: 'SocialStoreBase.setGroupTasks');
    try {
      return super.setGroupTasks(tasks);
    } finally {
      _$SocialStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$SocialStoreBaseActionController.startAction(
        name: 'SocialStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$SocialStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$SocialStoreBaseActionController.startAction(
        name: 'SocialStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$SocialStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
groupTasks: ${groupTasks},
friendMissions: ${friendMissions},
todayGroupTasks: ${todayGroupTasks},
error: ${error},
isLoading: ${isLoading}
    ''';
  }
}
