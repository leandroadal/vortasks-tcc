// Lista de conquistas com moedas e gemas como recompensa
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:vortasks/models/achievement/achievement.dart';
import 'package:vortasks/models/enums/goal_type.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/goals/goal_history.dart';
import 'package:vortasks/stores/user_data/level_store.dart';
import 'package:vortasks/stores/shop/sell_store.dart';
import 'package:vortasks/stores/tasks/task_store.dart';
import 'package:vortasks/stores/user_data/check_in/checkin_store.dart';
import 'package:vortasks/stores/user_data/goals/goal_history_store.dart';
import 'package:vortasks/stores/user_data/goals/goals_store.dart';

List<Achievement> createDefaultAchievements() {
  return [
    // Conquistas relacionadas a tarefas
    Achievement(
      id: 'achievement_1',
      title: 'Iniciante',
      description: 'Conclua 5 tarefas.',
      coins: 50,
      gems: 5,
      unlocked: false,
    ),
    Achievement(
      id: 'achievement_2',
      title: 'Produtivo',
      description: 'Conclua 25 tarefas.',
      coins: 150,
      gems: 15,
    ),
    Achievement(
      id: 'achievement_3',
      title: 'Mestre Tarefeiro',
      description: 'Conclua 100 tarefas.',
      coins: 500,
      gems: 50,
    ),
    Achievement(
      id: 'achievement_4',
      title: 'Semanalmente Consistente',
      description: 'Conclua todas as suas metas semanais por um mês.',
      coins: 1000,
      gems: 100,
    ),
    Achievement(
      id: 'achievement_5',
      title: 'Especialista',
      description: 'Conclua 5 tarefas de uma mesma habilidade.',
      coins: 200,
      gems: 20,
    ),
    Achievement(
      id: 'achievement_6',
      title: 'Multitalentoso',
      description: 'Conclua tarefas em 5 habilidades diferentes.',
      coins: 300,
      gems: 30,
    ),
    // Conquistas relacionadas a check-in
    Achievement(
      id: 'achievement_7',
      title: 'Presente Diário',
      description: 'Faça check-in por 7 dias consecutivos.',
      coins: 150,
      gems: 15,
    ),
    Achievement(
      id: 'achievement_8',
      title: 'Compromisso de um Mês',
      description: 'Faça check-in por 30 dias consecutivos.',
      coins: 500,
      gems: 50,
    ),
    // Conquistas relacionadas a compras na loja
    Achievement(
      id: 'achievement_9',
      title: 'Primeiro Item',
      description: 'Compre seu primeiro item na loja.',
      coins: 100,
      gems: 10,
    ),
    Achievement(
      id: 'achievement_10',
      title: 'Comprador Assíduo',
      description: 'Compre 10 itens na loja.',
      coins: 300,
      gems: 30,
    ),
    // Conquistas relacionadas ao nível do jogador
    Achievement(
      id: 'achievement_11',
      title: 'Subindo de Nível',
      description: 'Alcance o nível 5.',
      coins: 100,
      gems: 10,
    ),
    Achievement(
      id: 'achievement_12',
      title: 'Progresso Notável',
      description: 'Alcance o nível 10.',
      coins: 250,
      gems: 25,
    ),
  ];
}

// Mapa que associa o ID da conquista à sua condição de desbloqueio
final Map<String, bool Function(TaskStore, CheckInStore, SellStore, LevelStore)>
    achievementUnlockConditions = {
  'achievement_1': (taskStore, checkInStore, sellStore, levelStore) =>
      taskStore.observableTasks.where((task) => task.finish == true).length >=
      5,
  'achievement_2': (taskStore, checkInStore, sellStore, levelStore) =>
      taskStore.observableTasks.where((task) => task.finish == true).length >=
      25,
  'achievement_3': (taskStore, checkInStore, sellStore, levelStore) =>
      taskStore.observableTasks.where((task) => task.finish == true).length >=
      100,
  'achievement_4': (taskStore, checkInStore, sellStore, levelStore) =>
      _hasCompletedWeeklyGoalsForMonth(taskStore),
  'achievement_5': (taskStore, checkInStore, sellStore, levelStore) =>
      _hasCompletedFiveTasksForSameSkill(taskStore),
  'achievement_6': (taskStore, checkInStore, sellStore, levelStore) =>
      _hasCompletedTasksForFiveDifferentSkills(taskStore),
  'achievement_7': (taskStore, checkInStore, sellStore, levelStore) =>
      _hasConsecutiveCheckIns(checkInStore, 7), // Verifica 7 dias consecutivos
  'achievement_8': (taskStore, checkInStore, sellStore, levelStore) =>
      _hasConsecutiveCheckIns(checkInStore, 30),
  'achievement_11': (taskStore, checkInStore, sellStore, levelStore) =>
      levelStore.currentLevel >= 5,
  'achievement_12': (taskStore, checkInStore, sellStore, levelStore) =>
      levelStore.currentLevel >= 10,
};

// Função para verificar se existem check-ins consecutivos nos últimos 'days' dias
bool _hasConsecutiveCheckIns(CheckInStore checkInStore, int days) {
  final now = DateTime.now().toUtc();
  final checkIns = checkInStore.checkIns;

  // Ordena os check-ins por data decrescente
  checkIns.sort((a, b) => b.lastCheckInDate!.compareTo(a.lastCheckInDate!));

  // Verifica se há check-ins consecutivos para os últimos 'days' dias
  for (int i = 0; i < days && i < checkIns.length; i++) {
    final checkInDate = checkIns[i].lastCheckInDate;
    if (checkInDate == null) {
      return false; // Não há data de check-in, então não é consecutivo
    }

    final expectedDate = now.subtract(Duration(days: i));
    if (checkInDate.year != expectedDate.year ||
        checkInDate.month != expectedDate.month ||
        checkInDate.day != expectedDate.day) {
      return false; // A data do check-in não é a esperada, então não é consecutivo
    }
  }

  return true; // Se chegou até aqui, todos os check-ins são consecutivos
}

// Função para verificar se o usuário completou todas as metas semanais durante um mês
bool _hasCompletedWeeklyGoalsForMonth(TaskStore taskStore) {
  final goalsStore = GetIt.I<GoalsStore>();
  final now = DateTime.now();

  // Obtém o primeiro e último dia do mês atual
  final firstDayOfMonth = DateTime(now.year, now.month, 1);
  final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

  // Calcula o número de semanas no mês
  int numWeeks = (lastDayOfMonth.difference(firstDayOfMonth).inDays / 7).ceil();

  // Itera sobre todas as semanas do mês
  for (int i = 0; i < numWeeks; i++) {
    // Calcula a data de início da semana
    DateTime startOfWeek = firstDayOfMonth.add(Duration(days: i * 7));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // Ajusta a data de início e término da semana para incluir dias do mês anterior e posterior
    if (startOfWeek.isBefore(firstDayOfMonth)) {
      startOfWeek = firstDayOfMonth;
    }
    if (endOfWeek.isAfter(lastDayOfMonth)) {
      endOfWeek = lastDayOfMonth;
    }

    // Obtém o progresso semanal para a semana, considerando os dias ajustados
    final weeklyProgressProductivity = _calculateWeeklyProgressForPeriod(
        startOfWeek, endOfWeek, TaskType.PRODUCTIVITY);
    final weeklyProgressWellBeing = _calculateWeeklyProgressForPeriod(
        startOfWeek, endOfWeek, TaskType.WELL_BEING);

    // Verifica se as metas de produtividade e bem-estar foram atingidas
    if (weeklyProgressProductivity < goalsStore.goals.weeklyProductivity ||
        weeklyProgressWellBeing < goalsStore.goals.weeklyWellBeing) {
      return false; // Retorna false se alguma meta semanal não for atingida
    }
  }

  return true; // Se chegou até aqui, todas as metas semanais foram cumpridas
}

// Função auxiliar para calcular o progresso semanal para um período específico
int _calculateWeeklyProgressForPeriod(
    DateTime startDate, DateTime endDate, TaskType taskType) {
  final goalHistoryStore = GetIt.I<GoalHistoryStore>();
  int totalProgress = 0;

  // Itera sobre os dias do período
  for (DateTime date = startDate;
      date.isBefore(endDate.add(const Duration(days: 1)));
      date = date.add(const Duration(days: 1))) {
    // Obtém o GoalHistory para o dia atual
    final dailyGoalHistory = goalHistoryStore.goalHistoryList.firstWhere(
      (gh) =>
          gh.date.year == date.year &&
          gh.date.month == date.month &&
          gh.date.day == date.day &&
          gh.type == taskType &&
          gh.goalType == GoalType.DAILY,
      orElse: () => GoalHistory(
        // Retorna um GoalHistory vazio se não encontrar
        id: const Uuid().v4(),
        date: date,
        weekNumber: _getWeekOfYear(date),
        type: taskType,
        goalType: GoalType.DAILY,
        successes: 0,
        failures: 0,
      ),
    );

    // Adiciona os sucessos do dia ao progresso total
    totalProgress += dailyGoalHistory.successes;
  }

  return totalProgress;
}

// Função para verificar se o usuário completou 5 tarefas para a mesma habilidade
bool _hasCompletedFiveTasksForSameSkill(TaskStore taskStore) {
  final completedTasks =
      taskStore.observableTasks.where((task) => task.finish == true).toList();

  // Cria um mapa para contar quantas tarefas foram concluídas para cada habilidade
  Map<String, int> skillTaskCount = {};

  for (var task in completedTasks) {
    for (var skill in task.skills) {
      skillTaskCount.update(skill.id, (value) => value + 1,
          ifAbsent: () =>
              1); // Incrementa a contagem ou adiciona a habilidade ao mapa
    }
  }

  // Verifica se alguma habilidade tem 5 ou mais tarefas concluídas
  return skillTaskCount.values.any((count) => count >= 5);
}

// Função para verificar se o usuário completou tarefas em 5 habilidades diferentes
bool _hasCompletedTasksForFiveDifferentSkills(TaskStore taskStore) {
  final completedTasks =
      taskStore.observableTasks.where((task) => task.finish == true).toList();

  // Cria um conjunto para armazenar as habilidades diferentes em que as tarefas foram concluídas
  Set<String> completedSkills = {};

  for (var task in completedTasks) {
    for (var skill in task.skills) {
      completedSkills.add(skill.id); // Adiciona a habilidade ao conjunto
    }
  }

  // Retorna true se o conjunto tiver 5 ou mais habilidades diferentes
  return completedSkills.length >= 5;
}

// Função auxiliar para obter o número da semana no ano
int _getWeekOfYear(DateTime date) {
  return ((date.difference(DateTime(date.year, 1, 1)).inDays +
                  DateTime(date.year, 1, 1).weekday -
                  1) /
              7)
          .floor() +
      1;
}
