import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/screens/statistics/all_charts_screen.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class WeeklyTasksPieChart extends StatelessWidget {
  const WeeklyTasksPieChart({super.key, required this.taskStore});

  final TaskStore taskStore;

  @override
  Widget build(BuildContext context) {
    int productivityTasks = _getCompletedTasksThisWeek(TaskType.PRODUCTIVITY);
    int leisureTasks = _getCompletedTasksThisWeek(TaskType.WELL_BEING);
    int totalTasks = productivityTasks + leisureTasks;

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Esta Semana',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AllChartsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  'Todos os gráficos',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para obter as tarefas completadas na semana atual
  int _getCompletedTasksThisWeek(TaskType type) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    return taskStore.observableTasks
        .where((task) =>
            task.type == type &&
            task.finish == true &&
            task.dateFinish != null &&
            task.dateFinish!.isAfter(startOfWeek) &&
            task.dateFinish!.isBefore(endOfWeek.add(const Duration(days: 1))))
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
