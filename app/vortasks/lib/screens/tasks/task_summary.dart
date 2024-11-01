import 'package:flutter/material.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/tasks/task.dart';

class TaskSummary extends StatelessWidget {
  final TaskType taskType;
  final List<Task> tasks;

  const TaskSummary({super.key, required this.taskType, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo de ${taskType.namePtBr}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildSummaryItem('Total de Tarefas:', tasks.length),
            _buildSummaryItem(
                'Concluídas:', tasks.where((task) => task.finish!).length),
            const SizedBox(height: 8.0),
            const Text(
              'Por Nível:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // TODO: Implementar resumo por nível
            const SizedBox(height: 8.0),
            const Text(
              'Por Dificuldade:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildSummaryItem(
                'Fácil:',
                tasks
                    .where((task) => task.difficulty == Difficulty.EASY)
                    .length),
            _buildSummaryItem(
                'Médio:',
                tasks
                    .where((task) => task.difficulty == Difficulty.MEDIUM)
                    .length),
            _buildSummaryItem(
                'Difícil:',
                tasks
                    .where((task) => task.difficulty == Difficulty.HARD)
                    .length),
            _buildSummaryItem(
                'Muito Difícil:',
                tasks
                    .where((task) => task.difficulty == Difficulty.VERY_HARD)
                    .length),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$value'),
        ],
      ),
    );
  }
}
