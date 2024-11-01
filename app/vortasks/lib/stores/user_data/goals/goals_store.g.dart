// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GoalsStore on GoalsStoreBase, Store {
  late final _$goalsAtom = Atom(name: 'GoalsStoreBase.goals', context: context);

  @override
  Goals get goals {
    _$goalsAtom.reportRead();
    return super.goals;
  }

  @override
  set goals(Goals value) {
    _$goalsAtom.reportWrite(value, super.goals, () {
      super.goals = value;
    });
  }

  late final _$GoalsStoreBaseActionController =
      ActionController(name: 'GoalsStoreBase', context: context);

  @override
  void setGoals(Goals goals) {
    final _$actionInfo = _$GoalsStoreBaseActionController.startAction(
        name: 'GoalsStoreBase.setGoals');
    try {
      return super.setGoals(goals);
    } finally {
      _$GoalsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateGoals(
      int dailyProductivity,
      int dailyWellBeing,
      int weeklyProductivity,
      int weeklyWellBeing,
      int dailyProductivityProgress,
      int dailyWellBeingProgress,
      int weeklyProductivityProgress,
      int weeklyWellBeingProgress) {
    final _$actionInfo = _$GoalsStoreBaseActionController.startAction(
        name: 'GoalsStoreBase.updateGoals');
    try {
      return super.updateGoals(
          dailyProductivity,
          dailyWellBeing,
          weeklyProductivity,
          weeklyWellBeing,
          dailyProductivityProgress,
          dailyWellBeingProgress,
          weeklyProductivityProgress,
          weeklyWellBeingProgress);
    } finally {
      _$GoalsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementGoalsCompleted(TaskType type) {
    final _$actionInfo = _$GoalsStoreBaseActionController.startAction(
        name: 'GoalsStoreBase.incrementGoalsCompleted');
    try {
      return super.incrementGoalsCompleted(type);
    } finally {
      _$GoalsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetDailyProgress() {
    final _$actionInfo = _$GoalsStoreBaseActionController.startAction(
        name: 'GoalsStoreBase.resetDailyProgress');
    try {
      return super.resetDailyProgress();
    } finally {
      _$GoalsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetWeeklyProgress() {
    final _$actionInfo = _$GoalsStoreBaseActionController.startAction(
        name: 'GoalsStoreBase.resetWeeklyProgress');
    try {
      return super.resetWeeklyProgress();
    } finally {
      _$GoalsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
goals: ${goals}
    ''';
  }
}
