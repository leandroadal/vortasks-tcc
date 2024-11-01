import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:vortasks/models/enums/goal_type.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/goals/goal_history.dart';
import 'package:vortasks/screens/statistics/base_bar_chart.dart';
import 'package:vortasks/stores/user_data/goals/goals_store.dart';

class WeeklyGoalBarChart extends StatefulWidget {
  const WeeklyGoalBarChart({super.key});

  @override
  State<WeeklyGoalBarChart> createState() => _WeeklyGoalBarChartState();
}

class _WeeklyGoalBarChartState extends State<WeeklyGoalBarChart> {
  final GoalsStore _goalsStore = GetIt.I<GoalsStore>();
  int _selectedMonth = DateTime.now().month;
  String _selectedGoalType = 'Produtividade';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o tipo de meta selecionado
    TaskType goalType = _selectedGoalType == 'Produtividade'
        ? TaskType.PRODUCTIVITY
        : TaskType.WELL_BEING;

    // Obtém os dados da meta semanal de acordo com o tipo selecionado
    List<Map<String, dynamic>> weeklyData =
        _getWeeklyGoalData(_selectedMonth, goalType);

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progresso da Meta Semanal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildMonthSelector(),
            const SizedBox(height: 8.0),
            _buildGoalTypeSelector(),
            const SizedBox(height: 40.0),
            SizedBox(
              height: 250,
              width: 320,
              child: BaseBarChart(
                title: 'Progresso da Meta Semanal',
                barData: weeklyData,
                barColors: const [Colors.green, Colors.red],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para obter os dados de sucessos e falhas na meta semanal por semana do mês
  List<Map<String, dynamic>> _getWeeklyGoalData(int month, TaskType type) {
    List<Map<String, dynamic>> data = [];

    int numWeeks = _getNumberOfWeeksInMonth(month);

    for (int weekOfMonth = 1; weekOfMonth <= numWeeks; weekOfMonth++) {
      DateTime dateOfWeek = _getDateOfWeekInMonth(_selectedMonth, weekOfMonth);

      // Calcula o número da semana no ano para a data calculada
      int weekOfYear = _getWeekOfYear(dateOfWeek);

      final weeklyProgress =
          _goalsStore.getWeeklyProgressForWeek(month, weekOfYear);

      // Extrai sucessos e falhas do GoalHistory,
      // usando 0 como padrão se não houver dados para o tipo de tarefa
      int successes = weeklyProgress
          .firstWhere(
            (gh) => gh.type == type,
            orElse: () => GoalHistory(
              id: '',
              date: DateTime.now(),
              weekNumber: 0,
              type: type,
              goalType: GoalType.WEEKLY,
              successes: 0,
              failures: 0,
            ),
          )
          .successes;
      int failures = weeklyProgress
          .firstWhere(
            (gh) => gh.type == type,
            orElse: () => GoalHistory(
              id: '',
              date: DateTime.now(),
              weekNumber: 0,
              type: type,
              goalType: GoalType.WEEKLY,
              successes: 0,
              failures: 0,
            ),
          )
          .failures;

      data.add({
        'label': 'Sem. $weekOfMonth', // Usa weekOfMonth para o label
        'successes': successes,
        'failures': failures,
      });
    }

    return data;
  }

  DateTime _getDateOfWeekInMonth(int month, int weekOfMonth) {
    // Começa no primeiro dia do mês
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, month, 1);

    // Calcula o dia da semana do primeiro dia do mês (1: segunda, 7: domingo)
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    // Ajusta weekdayOfFirstDay para começar em domingo (0)
    weekdayOfFirstDay = (weekdayOfFirstDay - 1) % 7;

    // Calcula o número de dias a serem adicionados
    int daysToAdd = (weekOfMonth - 1) * 7 - weekdayOfFirstDay;

    // Adiciona os dias ao primeiro dia do mês
    return firstDayOfMonth.add(Duration(days: daysToAdd));
  }

  int _getNumberOfWeeksInMonth(int month) {
    DateTime now = DateTime.now();
    DateTime firstDay = DateTime(now.year, month, 1);
    DateTime lastDay = DateTime(now.year, month + 1, 0);

    int daysInMonth = lastDay.difference(firstDay).inDays + 1;
    int numWeeks = (daysInMonth / 7).floor();

    if (daysInMonth % 7 != 0) {
      numWeeks++;
    }

    return numWeeks;
  }

  int _getWeekOfYear(DateTime date) {
    return ((date.difference(DateTime(date.year, 1, 1)).inDays +
                    DateTime(date.year, 1, 1).weekday -
                    1) /
                7)
            .floor() +
        1;
  }

  Widget _buildMonthSelector() {
    List<DropdownMenuItem<int>> monthItems = [];
    for (int i = 1; i <= 12; i++) {
      monthItems.add(
        DropdownMenuItem(
          value: i,
          child: Text(DateFormat('MMMM').format(DateTime(2023, i))),
        ),
      );
    }

    return DropdownButton<int>(
      value: _selectedMonth,
      onChanged: (int? newValue) {
        setState(() {
          _selectedMonth = newValue!;
        });
      },
      items: monthItems,
    );
  }

  // Widget para o seletor de tipo de meta
  Widget _buildGoalTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => setState(() => _selectedGoalType = 'Produtividade'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedGoalType == 'Produtividade'
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Text(
            'Produtividade',
            style: TextStyle(
              color: _selectedGoalType == 'Produtividade'
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: () => setState(() => _selectedGoalType = 'Bem-estar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedGoalType == 'Bem-estar'
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Text(
            'Bem-estar',
            style: TextStyle(
              color: _selectedGoalType == 'Bem-estar'
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
