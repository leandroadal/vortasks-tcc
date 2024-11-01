// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GoalHistoryStore on GoalHistoryStoreBase, Store {
  late final _$goalHistoryListAtom =
      Atom(name: 'GoalHistoryStoreBase.goalHistoryList', context: context);

  @override
  ObservableList<GoalHistory> get goalHistoryList {
    _$goalHistoryListAtom.reportRead();
    return super.goalHistoryList;
  }

  @override
  set goalHistoryList(ObservableList<GoalHistory> value) {
    _$goalHistoryListAtom.reportWrite(value, super.goalHistoryList, () {
      super.goalHistoryList = value;
    });
  }

  late final _$GoalHistoryStoreBaseActionController =
      ActionController(name: 'GoalHistoryStoreBase', context: context);

  @override
  void addGoalHistory(GoalHistory goalHistory) {
    final _$actionInfo = _$GoalHistoryStoreBaseActionController.startAction(
        name: 'GoalHistoryStoreBase.addGoalHistory');
    try {
      return super.addGoalHistory(goalHistory);
    } finally {
      _$GoalHistoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateGoalHistory(GoalHistory goalHistory) {
    final _$actionInfo = _$GoalHistoryStoreBaseActionController.startAction(
        name: 'GoalHistoryStoreBase.updateGoalHistory');
    try {
      return super.updateGoalHistory(goalHistory);
    } finally {
      _$GoalHistoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeGoalHistory(String goalHistoryId) {
    final _$actionInfo = _$GoalHistoryStoreBaseActionController.startAction(
        name: 'GoalHistoryStoreBase.removeGoalHistory');
    try {
      return super.removeGoalHistory(goalHistoryId);
    } finally {
      _$GoalHistoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
goalHistoryList: ${goalHistoryList}
    ''';
  }
}
