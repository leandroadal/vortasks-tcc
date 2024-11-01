import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class TaskCompletionChart extends StatefulWidget {
  const TaskCompletionChart({super.key});

  @override
  State<TaskCompletionChart> createState() => _TaskCompletionChartState();
}

class _TaskCompletionChartState extends State<TaskCompletionChart> {
  final TaskStore taskStore = GetIt.I<TaskStore>();
  String _selectedPeriod = 'Semanal';

  @override
  Widget build(BuildContext context) {
    int productivityTasks = _getCompletedTasksByPeriod(TaskType.PRODUCTIVITY);
    int leisureTasks = _getCompletedTasksByPeriod(TaskType.WELL_BEING);
    int totalTasks = productivityTasks + leisureTasks;

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarefas Concluídas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildPeriodSelector(),
            const SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 30,
                      sections: totalTasks == 0
                          ? [
                              PieChartSectionData(
                                color: Colors.grey[300],
                                value: 100,
                                title: '',
                                radius: 40,
                                showTitle: false,
                              ),
                            ]
                          : [
                              PieChartSectionData(
                                color: const Color(0xff0293ee),
                                value: productivityTasks / totalTasks * 100,
                                title:
                                    '${(productivityTasks / totalTasks * 100).toStringAsFixed(0)}%',
                                radius: 40,
                                titleStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffffffff)),
                              ),
                              PieChartSectionData(
                                color: const Color(0xfff8b250),
                                value: leisureTasks / totalTasks * 100,
                                title:
                                    '${(leisureTasks / totalTasks * 100).toStringAsFixed(0)}%',
                                radius: 40,
                                titleStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffffffff)),
                              ),
                            ],
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 150),
                    swapAnimationCurve: Curves.linear,
                  ),
                ),
                const SizedBox(width: 32),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIndicator(context, const Color(0xff0293ee),
                        'Produtividade', productivityTasks),
                    const SizedBox(height: 4),
                    _buildIndicator(context, const Color(0xfff8b250),
                        'Bem-estar', leisureTasks),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return DropdownButton<String>(
      value: _selectedPeriod,
      onChanged: (String? newValue) {
        setState(() {
          _selectedPeriod = newValue!;
        });
      },
      items: const <String>['Semanal', 'Mensal', 'Anual']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  int _getCompletedTasksByPeriod(TaskType type) {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now;

    switch (_selectedPeriod) {
      case 'Semanal':
        // Calcula o início da semana (domingo)
        startDate = now.subtract(Duration(days: now.weekday % 7));
        break;
      case 'Mensal':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'Anual':
        startDate = DateTime(now.year, 1, 1);
        break;
      default:
        startDate = now.subtract(Duration(days: now.weekday % 7));
    }

    return taskStore.observableTasks
        .where((task) =>
            task.type == type &&
            task.finish == true &&
            task.dateFinish != null &&
            task.dateFinish!.isAfter(startDate) &&
            task.dateFinish!.isBefore(endDate))
        .length;
  }

  Widget _buildIndicator(
      BuildContext context, Color color, String title, int value) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
            Text(
              '$value tarefas',
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
          ],
        )
      ],
    );
  }
}
