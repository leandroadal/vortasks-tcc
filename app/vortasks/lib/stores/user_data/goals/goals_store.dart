import 'dart:async';
import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'package:vortasks/models/enums/goal_type.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/goals/goal_history.dart';
import 'package:vortasks/models/goals/goals.dart';
import 'package:vortasks/stores/user_data/goals/goal_history_store.dart';

part 'goals_store.g.dart';

class GoalsStore = GoalsStoreBase with _$GoalsStore;

abstract class GoalsStoreBase with Store {
  GoalsStoreBase() {
    _loadGoals();
    _initializeResetChecks();
  }

  @observable
  Goals goals = Goals(
    id: '...',
    dailyProductivity: 3,
    dailyWellBeing: 2,
    weeklyProductivity: 21,
    weeklyWellBeing: 14,
    dailyProductivityProgress: 0,
    dailyWellBeingProgress: 0,
    weeklyProductivityProgress: 0,
    weeklyWellBeingProgress: 0,
  );

  @action
  void setGoals(Goals goals) {
    this.goals = goals;
    _saveGoals();
  }

  @action
  void updateGoals(
    int dailyProductivity,
    int dailyWellBeing,
    int weeklyProductivity,
    int weeklyWellBeing,
    int dailyProductivityProgress,
    int dailyWellBeingProgress,
    int weeklyProductivityProgress,
    int weeklyWellBeingProgress,
  ) {
    goals = Goals(
      id: goals.id,
      dailyProductivity: dailyProductivity,
      dailyWellBeing: dailyWellBeing,
      weeklyProductivity: weeklyProductivity,
      weeklyWellBeing: weeklyWellBeing,
      dailyProductivityProgress: dailyProductivityProgress,
      dailyWellBeingProgress: dailyWellBeingProgress,
      weeklyProductivityProgress: weeklyProductivityProgress,
      weeklyWellBeingProgress: weeklyWellBeingProgress,
    );
    _saveGoals();
  }

  @action
  void incrementGoalsCompleted(TaskType type) {
    switch (type) {
      case TaskType.PRODUCTIVITY:
        goals = goals.copyWith(
          dailyProductivityProgress: goals.dailyProductivityProgress + 1,
          weeklyProductivityProgress: goals.weeklyProductivityProgress + 1,
        );
        break;
      case TaskType.WELL_BEING:
        goals = goals.copyWith(
          dailyWellBeingProgress: goals.dailyWellBeingProgress + 1,
          weeklyWellBeingProgress: goals.weeklyWellBeingProgress + 1,
        );
        break;
    }
    _saveGoals();
  }

  // Métodos para consultar o progresso das metas
  List<GoalHistory> getDailyProgressForDate(DateTime date) {
    final goalHistoryStore = GetIt.I<GoalHistoryStore>();
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    return goalHistoryStore.goalHistoryList
        .where((gh) =>
            DateFormat('yyyy-MM-dd').format(gh.date) == dateKey &&
            gh.goalType == GoalType.DAILY)
        .toList();
  }

  List<GoalHistory> getWeeklyProgressForWeek(int month, int weekNumber) {
    final goalHistoryStore = GetIt.I<GoalHistoryStore>();
    return goalHistoryStore.goalHistoryList
        .where((gh) =>
            gh.date.month == month &&
            gh.weekNumber == weekNumber &&
            gh.goalType == GoalType.WEEKLY)
        .toList();
  }

  // ----- Funções para reiniciar o progresso das metas -----

  @action
  void resetDailyProgress() {
    goals = goals.copyWith(
      dailyProductivityProgress: 0,
      dailyWellBeingProgress: 0,
    );
    _saveGoals();
    _saveLastDailyReset();
  }

  @action
  void resetWeeklyProgress() {
    goals = goals.copyWith(
      weeklyProductivityProgress: 0,
      weeklyWellBeingProgress: 0,
    );
    _saveGoals();
  }

  void _initializeResetChecks() {
    _checkAndResetDailyProgress();
    _initializeTimers();
  }

  void _checkAndResetDailyProgress() {
    final now = DateTime.now();
    final lastDailyReset = _loadLastDailyReset();
    if (lastDailyReset == null || !isSameDay(now, lastDailyReset)) {
      resetDailyProgress();
    }

    // Verifica se é domingo e se o último reset semanal NÃO foi hoje
    if (now.weekday == DateTime.sunday && !_wasWeeklyResetToday()) {
      resetWeeklyProgress();
      _saveLastWeeklyReset(); // Salva a data do último reset semanal
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // Verifica se o reset semanal já foi feito hoje
  bool _wasWeeklyResetToday() {
    final lastWeeklyReset = _loadLastWeeklyReset();
    return lastWeeklyReset != null &&
        isSameDay(DateTime.now(), lastWeeklyReset);
  }

  void _initializeTimers() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0);

    Timer(nextMidnight.difference(now), () {
      resetDailyProgress();
      if (DateTime.now().weekday == DateTime.sunday) {
        resetWeeklyProgress();
      }
      _initializeTimers();
    });
  }

  // ----- Funções para salvar no Armazenamento local -----

  DateTime? _loadLastDailyReset() {
    final lastReset = LocalStorage.getString('lastDailyReset');
    return lastReset != null ? DateTime.parse(lastReset) : null;
  }

  void _saveLastDailyReset() {
    LocalStorage.saveData('lastDailyReset', DateTime.now().toIso8601String());
  }

  // Carrega a data do último reset semanal
  DateTime? _loadLastWeeklyReset() {
    final lastReset = LocalStorage.getString('lastWeeklyReset');
    return lastReset != null ? DateTime.parse(lastReset) : null;
  }

  // Salva a data do último reset semanal
  void _saveLastWeeklyReset() {
    LocalStorage.saveData('lastWeeklyReset', DateTime.now().toIso8601String());
  }

  // Carregar goals do armazenamento local
  void _loadGoals() {
    final goalsJson = LocalStorage.getString('goals');
    if (goalsJson != null) {
      goals = Goals.fromJson(json.decode(goalsJson));
    }
  }

  // Salvar goals no armazenamento local
  void _saveGoals() {
    LocalStorage.saveData('goals', json.encode(goals.toJson()));
  }
}
