// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observable_task.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ObservableTask on ObservableTaskBase, Store {
  late final _$taskAtom =
      Atom(name: 'ObservableTaskBase.task', context: context);

  @override
  Task get task {
    _$taskAtom.reportRead();
    return super.task;
  }

  @override
  set task(Task value) {
    _$taskAtom.reportWrite(value, super.task, () {
      super.task = value;
    });
  }

  late final _$ObservableTaskBaseActionController =
      ActionController(name: 'ObservableTaskBase', context: context);

  @override
  void setStatus(Status newStatus) {
    final _$actionInfo = _$ObservableTaskBaseActionController.startAction(
        name: 'ObservableTaskBase.setStatus');
    try {
      return super.setStatus(newStatus);
    } finally {
      _$ObservableTaskBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFinish(bool? newFinish) {
    final _$actionInfo = _$ObservableTaskBaseActionController.startAction(
        name: 'ObservableTaskBase.setFinish');
    try {
      return super.setFinish(newFinish);
    } finally {
      _$ObservableTaskBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDateFinish(DateTime? newDateFinish) {
    final _$actionInfo = _$ObservableTaskBaseActionController.startAction(
        name: 'ObservableTaskBase.setDateFinish');
    try {
      return super.setDateFinish(newDateFinish);
    } finally {
      _$ObservableTaskBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void markAsFinished() {
    final _$actionInfo = _$ObservableTaskBaseActionController.startAction(
        name: 'ObservableTaskBase.markAsFinished');
    try {
      return super.markAsFinished();
    } finally {
      _$ObservableTaskBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
task: ${task}
    ''';
  }
}
