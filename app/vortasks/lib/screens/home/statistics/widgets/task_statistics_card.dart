import 'package:flutter/material.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/screens/tasks/task_summary.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class TaskStatisticsCard extends StatelessWidget {
  const TaskStatisticsCard({super.key, required this.taskStore});

  final TaskStore taskStore;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estatísticas das Tarefas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Wrap para organizar os itens de estatística
            Card(
              child: Wrap(
                spacing: 8.0, // Espaçamento horizontal entre os itens
                runSpacing: 8.0, // Espaçamento vertical entre as linhas
                children: [
                  _buildStatisticGridItem(
                    context,
                    'Tarefas Criadas',
                    taskStore.observableTasks.length,
                    Icons.create,
                  ),
                  _buildStatisticGridItem(
                    context,
                    'Tarefas Concluídas',
                    taskStore.observableTasks
                        .where((task) => task.status == Status.COMPLETED)
                        .length,
                    Icons.check_circle,
                    details: _buildCompletedTasksDetails(),
                  ),
                  _buildStatisticGridItem(
                    context,
                    'Concluídas com Atraso',
                    _calculateDelayedTasks(),
                    Icons.warning,
                  ),
                  _buildStatisticGridItem(
                    context,
                    'Tarefas em Andamento',
                    taskStore.observableTasks
                        .where((task) => task.status == Status.IN_PROGRESS)
                        .length,
                    Icons.play_circle,
                  ),
                  _buildStatisticGridItem(
                    context,
                    'Repetição Diária',
                    taskStore.observableTasks
                        .where((task) => task.repetition == 1)
                        .length,
                    Icons.repeat,
                  ),
                  _buildStatisticGridItem(
                    context,
                    'Repetição Semanal',
                    taskStore.observableTasks
                        .where((task) => task.repetition == 7)
                        .length,
                    Icons.repeat_one,
                  ),
                  _buildStatisticGridItem(
                    context,
                    'Repetição Mensal',
                    taskStore.observableTasks
                        .where((task) => task.repetition == 30)
                        .length,
                    Icons.calendar_today,
                  ),
                  _buildStatisticGridItem(
                    context,
                    'Tarefas com Alarme',
                    taskStore.observableTasks
                        .where((task) => task.reminder != task.endDate)
                        .length,
                    Icons.alarm,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TaskSummary(
                taskType: TaskType.PRODUCTIVITY,
                tasks: taskStore.observableTasks
                    .map((task) => task.task)
                    .toList()),
            const SizedBox(height: 8),
            TaskSummary(
                taskType: TaskType.WELL_BEING,
                tasks: taskStore.observableTasks
                    .map((task) => task.task)
                    .toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedTasksDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatisticItem(
            '- Produção:',
            taskStore.observableTasks
                .where((task) =>
                    task.status == Status.COMPLETED &&
                    task.type == TaskType.PRODUCTIVITY)
                .length,
          ),
          _buildStatisticItem(
            '- Bem-estar:',
            taskStore.observableTasks
                .where((task) =>
                    task.status == Status.COMPLETED &&
                    task.type == TaskType.WELL_BEING)
                .length,
          ),
        ],
      ),
    );
  }

  // Widget para construir cada item da grade de estatísticas
  Widget _buildStatisticGridItem(
      BuildContext context, String label, int value, IconData icon,
      {Widget? details}) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8.0),
              Text(
                '$label: $value',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          //Text('$value'),
          if (details != null) details,
        ],
      ),
    );
  }

  // Widget para construir cada item de estatística
  Widget _buildStatisticItem(String label, int value) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('$value'),
      ],
    );
  }

  // Função para calcular o número de tarefas concluídas com atraso
  int _calculateDelayedTasks() {
    return taskStore.observableTasks
        .where((task) =>
            task.status == Status.COMPLETED &&
            task.dateFinish != null &&
            task.dateFinish!.isAfter(task.endDate))
        .length;
  }
}
