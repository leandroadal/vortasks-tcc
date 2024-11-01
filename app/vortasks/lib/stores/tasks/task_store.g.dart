// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on TaskStoreBase, Store {
  late final _$observableTasksAtom =
      Atom(name: 'TaskStoreBase.observableTasks', context: context);

  @override
  ObservableList<ObservableTask> get observableTasks {
    _$observableTasksAtom.reportRead();
    return super.observableTasks;
  }

  @override
  set observableTasks(ObservableList<ObservableTask> value) {
    _$observableTasksAtom.reportWrite(value, super.observableTasks, () {
      super.observableTasks = value;
    });
  }

  late final _$todayTasksAtom =
      Atom(name: 'TaskStoreBase.todayTasks', context: context);

  @override
  List<Task> get todayTasks {
    _$todayTasksAtom.reportRead();
    return super.todayTasks;
  }

  @override
  set todayTasks(List<Task> value) {
    _$todayTasksAtom.reportWrite(value, super.todayTasks, () {
      super.todayTasks = value;
    });
  }

  late final _$completeTaskAsyncAction =
      AsyncAction('TaskStoreBase.completeTask', context: context);

  @override
  Future<void> completeTask(Task task) {
    return _$completeTaskAsyncAction.run(() => super.completeTask(task));
  }

  late final _$completeOverdueTaskAsyncAction =
      AsyncAction('TaskStoreBase.completeOverdueTask', context: context);

  @override
  Future<void> completeOverdueTask(Task task) {
    return _$completeOverdueTaskAsyncAction
        .run(() => super.completeOverdueTask(task));
  }

  late final _$TaskStoreBaseActionController =
      ActionController(name: 'TaskStoreBase', context: context);

  @override
  void setTasks(List<Task> tasks) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.setTasks');
    try {
      return super.setTasks(tasks);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTask(Task task) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.addTask');
    try {
      return super.addTask(task);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTask(Task task) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.updateTask');
    try {
      return super.updateTask(task);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateOverdueTask(Task task) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.updateOverdueTask');
    try {
      return super.updateOverdueTask(task);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteTask(String taskId) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.deleteTask');
    try {
      return super.deleteTask(taskId);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateTodayTasks() {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase._updateTodayTasks');
    try {
      return super._updateTodayTasks();
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void failTask(Task task) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.failTask');
    try {
      return super.failTask(task);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
observableTasks: ${observableTasks},
todayTasks: ${todayTasks}
    ''';
  }
}
