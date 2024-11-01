// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GroupTaskStore on GroupTaskStoreBase, Store {
  late final _$groupTasksAtom =
      Atom(name: 'GroupTaskStoreBase.groupTasks', context: context);

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

  late final _$errorAtom =
      Atom(name: 'GroupTaskStoreBase.error', context: context);

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
      Atom(name: 'GroupTaskStoreBase.isLoading', context: context);

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

  late final _$GroupTaskStoreBaseActionController =
      ActionController(name: 'GroupTaskStoreBase', context: context);

  @override
  void setGroupTasks(List<GroupTask> tasks) {
    final _$actionInfo = _$GroupTaskStoreBaseActionController.startAction(
        name: 'GroupTaskStoreBase.setGroupTasks');
    try {
      return super.setGroupTasks(tasks);
    } finally {
      _$GroupTaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? value) {
    final _$actionInfo = _$GroupTaskStoreBaseActionController.startAction(
        name: 'GroupTaskStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$GroupTaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$GroupTaskStoreBaseActionController.startAction(
        name: 'GroupTaskStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$GroupTaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
groupTasks: ${groupTasks},
error: ${error},
isLoading: ${isLoading}
    ''';
  }
}
