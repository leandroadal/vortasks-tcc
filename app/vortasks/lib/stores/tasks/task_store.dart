import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'package:vortasks/models/achievement/achievement_data.dart';
import 'package:vortasks/models/enums/goal_type.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/goals/goal_history.dart';
import 'package:vortasks/models/tasks/task.dart';
import 'package:vortasks/screens/tasks/widgets/task_form.dart';
import 'package:vortasks/services/notification_service.dart';
import 'package:vortasks/stores/user_data/goals/goal_history_store.dart';
import 'package:vortasks/stores/user_data/goals/goals_store.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'dart:convert';

import 'package:vortasks/stores/user_data/level_store.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
import 'package:vortasks/stores/shop/sell_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_level_store.dart';
import 'package:vortasks/stores/tasks/observable_task.dart';
import 'package:vortasks/stores/user_data/achievement/achievement_store.dart';
import 'package:vortasks/stores/user_data/check_in/checkin_store.dart';
import 'package:vortasks/stores/user_store.dart';

part 'task_store.g.dart';

class TaskStore = TaskStoreBase with _$TaskStore;

abstract class TaskStoreBase with Store {
  TaskStoreBase() {
    _loadTasks();
    _startExpiredTasksCheck();
  }
  final LevelStore _levelStore = GetIt.I<LevelStore>();
  final SkillLevelStore _skillLevelStore = GetIt.I<SkillLevelStore>();
  final SellStore _sellStore = GetIt.I<SellStore>();
  final GoalsStore goalsStore = GetIt.I<GoalsStore>();
  final NotificationService _notificationService =
      GetIt.I<NotificationService>();

  @observable
  ObservableList<ObservableTask> observableTasks =
      ObservableList<ObservableTask>();

  @action
  void setTasks(List<Task> tasks) {
    observableTasks.clear();
    // Converte cada Task para ObservableTask ao adicionar
    observableTasks.addAll(tasks.map((task) => ObservableTask(task: task)));
    _saveTasks();
  }

  @observable
  List<Task> todayTasks = [];

  @action
  void addTask(Task task) {
    observableTasks.add(ObservableTask(task: task));
    _saveTasks();
    _updateTodayTasks(); // Atualiza as tarefas do dia
  }

  @action
  void updateTask(Task task) {
    final index = observableTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      observableTasks[index] = ObservableTask(task: task);
      _saveTasks();
      _updateTodayTasks();
    }
  }

  @action
  void updateOverdueTask(Task task) {
    final index = observableTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      observableTasks[index] = ObservableTask(task: task);
      _saveTasks();
      _updateTodayTasks();
    }
  }

  @action
  void deleteTask(String taskId) {
    observableTasks.removeWhere((task) => task.id == taskId);
    _saveTasks();
    _updateTodayTasks();
  }

  @action
  void _updateTodayTasks() {
    todayTasks = observableTasks
        .map((observableTask) => observableTask.task)
        .where((task) =>
            _isBetweenStartDateEndDate(task.startDate, task.endDate) &&
            task.status == Status.IN_PROGRESS)
        .toList();
  }

  @action
  Future<void> completeTask(Task task) async {
    if (task.repetition > 0) {
      _repeatTask(task);
    }
    task.status = Status.COMPLETED;
    DateTime today = DateTime.now();
    task.dateFinish = today.toUtc();
    task.finish = true;
    updateTask(task);
    _earnXP(task);

    _incrementGoalProgress(task);

    _sellStore.incrementCoins(task.coins);

    // Atualiza o remoto com os dados mais recentes
    sendProgressToRemote();

    checkAchievements();
  }

  void sendProgressToRemote() {
    GetIt.I<ProgressStore>().setLastModified(DateTime.now().toUtc());
    if (GetIt.I<UserStore>().isLoggedIn) {
      GetIt.I<ProgressStore>().toRemote();
    }
  }

  @action
  Future<void> completeOverdueTask(Task task) async {
    task.status = Status.COMPLETED;
    DateTime today = DateTime.now();
    task.dateFinish = today.toUtc();
    updateTask(task);
    _earnXP(task, overdue: true);

    // Atualizando as moedas com a penalidade de atraso
    int coins = task.coins - (task.coins ~/ 2);
    _sellStore.incrementCoins(coins);

    sendProgressToRemote();

    checkAchievements();
  }

  void _earnXP(Task task, {bool overdue = false}) {
    int xp = 0;
    if (overdue) {
      xp = task.xp - (task.xp ~/ 2);
    } else {
      xp = task.xp;
    }
    _levelStore.addXP(xp); // Incrementa o XP do usuário
    _levelStore.xpPercentage; // Recalcula a porcentagem de XP

    for (var skill in task.skills) {
      _skillLevelStore.addSkillXP(skill.id, task.skillIncrease);
    }
  }

  // Quando o usuário falha em completar a tarefa
  @action
  void failTask(Task task) {
    if (task.repetition > 0) {
      _repeatTask(task);
    }
    task.status = Status.FAILED;
    task.dateFinish = DateTime.now().toUtc();
    task.finish = true;
    updateTask(task);
    loseXP(task);
    _sellStore.decrementCoins(task.coins);

    sendProgressToRemote();
  }

  void loseXP(Task task) {
    _levelStore.rmXP(task.xp); // Decrementa o XP do usuário
    _levelStore.xpPercentage; // Recalcula a porcentagem de XP

    for (var skill in task.skills) {
      _skillLevelStore.addSkillXP(skill.id, -task.skillDecrease);
    }
  }

  // ============== FUNÇÕES AUXILIARES ==============

  bool _isBetweenStartDateEndDate(DateTime startDate, DateTime endDate) {
    final today = DateTime.now();

    // Verifica se a data de hoje está dentro do intervalo de anos
    if (today.year < startDate.year || today.year > endDate.year) {
      return false;
    }

    // Verifica se a data de hoje está dentro do intervalo de meses
    if (today.month < startDate.month || today.month > endDate.month) {
      return false;
    }

    // Se o mês de início e término forem iguais, verifica o dia
    if (startDate.month == endDate.month) {
      return today.day >= startDate.day && today.day <= endDate.day;
    } else {
      // Se o mês de início for menor que o mês de término, verifica se a data de hoje está:
      // Depois do dia de início do mês de início ou
      // Antes do dia de término do mês de término
      return (today.month == startDate.month && today.day >= startDate.day) ||
          (today.month == endDate.month && today.day <= endDate.day);
    }
  }

  void _incrementGoalProgress(Task task) {
    goalsStore.incrementGoalsCompleted(task.type);

    final goalHistoryStore = GetIt.I<GoalHistoryStore>();
    DateTime now = DateTime.now();
    int weekNumber = _getWeekOfYear(now);

    // Lógica para progresso diário
    _updateGoalHistory(
        goalHistoryStore, now, weekNumber, task.type, GoalType.DAILY);

    // Lógica para progresso semanal
    _updateGoalHistory(
        goalHistoryStore, now, weekNumber, task.type, GoalType.WEEKLY);
  }

  void _updateGoalHistory(GoalHistoryStore goalHistoryStore, DateTime now,
      int weekNumber, TaskType taskType, GoalType goalType) {
    // Cria um novo GoalHistory para o orElse
    GoalHistory newGoalHistory = GoalHistory(
      id: const Uuid().v4(),
      date: now,
      weekNumber: weekNumber,
      type: taskType,
      goalType: goalType,
      successes: 0,
      failures: 0,
    );

    // Encontra o GoalHistory existente com base na data, tipo de tarefa e tipo de meta
    var existingGoalHistory = goalHistoryStore.goalHistoryList.firstWhere(
      (gh) =>
          gh.date.year == now.year &&
          gh.date.month == now.month &&
          (goalType == GoalType.DAILY
              ? gh.date.day == now.day
              : true) && // Verifica o dia apenas se for meta diária
          gh.weekNumber == weekNumber &&
          gh.type == taskType &&
          gh.goalType == goalType,
      orElse: () => newGoalHistory, // Retorna o newGoalHistory se não encontrar
    );

    if (existingGoalHistory != newGoalHistory) {
      // Se encontrou um progresso real, incrementa sucessos e decrementa falhas (se houver)
      existingGoalHistory.successes++;
      if (existingGoalHistory.failures > 0) {
        existingGoalHistory.failures--;
      }
      goalHistoryStore.updateGoalHistory(existingGoalHistory);
    } else {
      // Se o existingGoalHistory é o newGoalHistory, significa que não havia um progresso para a data/semana,
      // então adiciona o new com 1 sucesso e calcula as falhas iniciais
      newGoalHistory.successes = 1;
      newGoalHistory.failures = _calculateInitialFailures(taskType, goalType);
      goalHistoryStore.addGoalHistory(newGoalHistory);
    }
  }

  int _calculateInitialFailures(TaskType taskType, GoalType goalType) {
    if (goalType == GoalType.DAILY) {
      // As falhas serão a meta - 1
      return taskType == TaskType.PRODUCTIVITY
          ? goalsStore.goals.dailyProductivity - 1
          : goalsStore.goals.dailyWellBeing - 1;
    } else {
      return taskType == TaskType.PRODUCTIVITY
          ? goalsStore.goals.weeklyProductivity - 1
          : goalsStore.goals.weeklyWellBeing - 1;
    }
  }

  void checkAchievements() {
    final taskStore = GetIt.I<TaskStore>();
    final checkInStore = GetIt.I<CheckInStore>();
    final sellStore = GetIt.I<SellStore>();
    final levelStore = GetIt.I<LevelStore>();
    final achievementStore = GetIt.I<AchievementStore>();

    for (var achievement in achievementStore.achievements) {
      final unlockCondition = achievementUnlockConditions[achievement.id];

      if (unlockCondition != null &&
          unlockCondition(taskStore, checkInStore, sellStore, levelStore) &&
          !achievement.unlocked) {
        // Verifica se a conquista está desbloqueada
        achievement.unlocked = true;
        achievementStore.updateAchievement(achievement);
        sellStore.incrementCoins(achievement.coins);
        sellStore.incrementGems(achievement.gems);
      }
    }
  }

  void _repeatTask(Task task) {
    DateTime newStartDate = task.startDate;
    DateTime newEndDate = task.endDate;
    DateTime newReminder = task.reminder;

    switch (task.repetition) {
      case 1: // Diária
        newStartDate = newStartDate.add(const Duration(days: 1));
        newEndDate = newEndDate.add(const Duration(days: 1));
        newReminder = newReminder.add(const Duration(days: 1));
        break;
      case 7: // Semanal
        newStartDate = newStartDate.add(const Duration(days: 7));
        newEndDate = newEndDate.add(const Duration(days: 7));
        newReminder = newReminder.add(const Duration(days: 7));
        break;
      case 30: // Mensal
        newStartDate = DateTime(
            newStartDate.year, newStartDate.month + 1, newStartDate.day);
        newEndDate =
            DateTime(newEndDate.year, newEndDate.month + 1, newEndDate.day);
        newReminder =
            DateTime(newReminder.year, newReminder.month + 1, newReminder.day);
        break;
    }

    // Cria uma nova tarefa com as novas datas
    Task newTask = Task(
      id: generateUUID(), // Gera um novo ID
      title: task.title,
      description: task.description,
      status: Status.IN_PROGRESS,
      xp: task.xp,
      coins: task.coins,
      type: task.type,
      repetition: task.repetition,
      reminder: newReminder,
      skills: task.skills,
      skillIncrease: task.skillIncrease,
      skillDecrease: task.skillDecrease,
      startDate: newStartDate,
      endDate: newEndDate,
      theme: task.theme,
      difficulty: task.difficulty,
      finish: false,
      dateFinish: null,
    );

    addTask(newTask);
  }

  // ============== FUNÇÕES DE CHECAGEM ==============

  // Função para iniciar a verificação de tarefas expiradas
  void _startExpiredTasksCheck() {
    tz.initializeTimeZones();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkExpiredTasks();
    });
  }

  // Função para verificar tarefas expiradas
  void _checkExpiredTasks() {
    final now = DateTime.now();
    List<Task> taskCopy = [];
    taskCopy
        .addAll(observableTasks.map((observableTask) => observableTask.task));
    for (var taskCopy
        in taskCopy.where((t) => t.status == Status.IN_PROGRESS)) {
      if (taskCopy.endDate.isBefore(now)) {
        Task task = observableTasks
            .map((observableTask) => observableTask.task)
            .firstWhere((t) => t.id == taskCopy.id);
        failTask(task);

        // Mostra diálogo ou notificação
        if (NotificationService.isAppForeground) {
          _showExpiredTaskDialog(taskCopy);
        } else {
          _notificationService.showNotification(
            title: 'Tarefa Falhou!',
            body: 'A tarefa "${taskCopy.title}" ultrapassou o prazo.',
            payload: taskCopy.id,
          );
        }
      }
    }
    taskCopy.clear();
  }

  // Função para mostrar o diálogo de tarefa expirada
  void _showExpiredTaskDialog(Task task) {
    showDialog(
      context: GetIt.I<GlobalKey<NavigatorState>>().currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tarefa Expirada'),
          content: Text('A tarefa "${task.title}" expirou.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  int _getWeekOfYear(DateTime date) {
    return ((date.difference(DateTime(date.year, 1, 1)).inDays +
                    DateTime(date.year, 1, 1).weekday -
                    1) /
                7)
            .floor() +
        1;
  }

  // ================ Armazenamento local ================

  // Carregar tarefas do armazenamento local
  void _loadTasks() {
    final tasksJson = LocalStorage.getString('tasks');
    if (tasksJson != null) {
      observableTasks = ObservableList.of((json.decode(tasksJson) as List)
          .map((e) => ObservableTask(task: Task.fromJson(e))));
    }
    _updateTodayTasks();
  }

  // Salvar tarefas no armazenamento local
  void _saveTasks() {
    final tasksJson = json.encode(observableTasks
        .map((observableTask) => observableTask.task.toJson())
        .toList());
    LocalStorage.saveData('tasks', tasksJson);
  }
}
