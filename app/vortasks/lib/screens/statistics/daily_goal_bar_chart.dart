import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:vortasks/models/enums/goal_type.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/goals/goal_history.dart';
import 'package:vortasks/stores/user_data/goals/goal_history_store.dart';

class DailyGoalBarChart extends StatefulWidget {
  const DailyGoalBarChart({super.key});

  @override
  State<DailyGoalBarChart> createState() => _DailyGoalBarChartState();
}

class _DailyGoalBarChartState extends State<DailyGoalBarChart> {
  final GoalHistoryStore _goalHistoryStore = GetIt.I<GoalHistoryStore>();
  int _selectedMonth = DateTime.now().month;
  late int _selectedWeek;
  String _selectedGoalType = 'Produtividade';

  // Função para obter a semana atual do mês
  int _getCurrentWeekOfMonth() {
    DateTime now = DateTime.now();
    int firstDayWeekday = DateTime(now.year, now.month, 1).weekday;
    return ((now.day + firstDayWeekday - 1) / 7).ceil();
  }

  // Função para obter os dados de sucessos e falhas na meta diária
  List<Map<String, dynamic>> _getDailyGoalData(
      int month, int week, TaskType type) {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, month, 1);
    DateTime startOfWeek = firstDayOfMonth.add(Duration(
      days: (week - 1) * 7 - firstDayOfMonth.weekday % 7,
    ));

    List<Map<String, dynamic>> data = [];

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startOfWeek.add(Duration(days: i));
      if (currentDate.month == month) {
        // Consulta o GoalHistoryStore para obter os dados do dia
        final dailyGoalHistory = _goalHistoryStore.goalHistoryList.firstWhere(
          (gh) =>
              gh.date.year == currentDate.year &&
              gh.date.month == currentDate.month &&
              gh.date.day == currentDate.day &&
              gh.type == type &&
              gh.goalType == GoalType.DAILY,
          orElse: () => GoalHistory(
            // Retorna um GoalHistory 'zerado' se não encontrar
            id: const Uuid().v4(),
            date: currentDate,
            weekNumber: _getWeekOfYear(currentDate),
            type: type,
            goalType: GoalType.DAILY,
            successes: 0,
            failures: 0,
          ),
        );

        data.add({
          'day': DateFormat('E').format(currentDate),
          'successes': dailyGoalHistory.successes,
          'failures': dailyGoalHistory.failures,
        });
      }
    }

    return data;
  }

  @override
  void initState() {
    super.initState();
    _selectedWeek = _getCurrentWeekOfMonth();
  }

  @override
  Widget build(BuildContext context) {
    TaskType goalType = _selectedGoalType == 'Produtividade'
        ? TaskType.PRODUCTIVITY
        : TaskType.WELL_BEING;

    List<Map<String, dynamic>> dailyData =
        _getDailyGoalData(_selectedMonth, _selectedWeek, goalType);

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progresso da Meta Diária',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildMonthSelector(),
            const SizedBox(height: 8.0),
            _buildGoalTypeSelector(),
            const SizedBox(height: 8.0),
            Center(child: _buildWeekSelector()),
            const SizedBox(height: 40.0),
            SizedBox(
              height: 250,
              width: 320,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: dailyData.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: data['successes'].toDouble(),
                          color: Colors.green,
                          width: 14,
                        ),
                        BarChartRodData(
                          toY: data['failures'].toDouble(),
                          color: Colors.red,
                          width: 14,
                        ),
                      ],
                      showingTooltipIndicators: [0, 1],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4,
                            child: Text(dailyData[value.toInt()]['day']),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipPadding: const EdgeInsets.all(0),
                      tooltipMargin: 8,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.toY.round().toString(),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          _selectedWeek = _getCurrentWeekOfMonth();
        });
      },
      items: monthItems,
    );
  }

  Widget _buildWeekSelector() {
    List<ElevatedButton> weekButtons = [];
    for (int i = 1; i <= 5; i++) {
      weekButtons.add(
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedWeek = i;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedWeek == i
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Text(
            '${i}ª Sem.',
            style: TextStyle(
              color: _selectedWeek == i
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8.0,
      children: weekButtons,
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
                    : Theme.of(context).colorScheme.onSecondaryContainer),
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
                    : Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
      ],
    );
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
}
