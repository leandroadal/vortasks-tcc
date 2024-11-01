import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/core/data/Icon_manager.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/screens/home/resume/widgets/tasks/icon_selection_screen.dart';
import 'package:vortasks/screens/tasks/task_info_screen.dart';
import 'package:vortasks/stores/tasks/observable_task.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class TaskTab extends StatelessWidget {
  final TaskType taskType;
  final TaskStore taskStore = GetIt.I<TaskStore>();

  TaskTab({super.key, required this.taskType});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        // Obtém a data de hoje
        final today = DateTime.now();
        today.subtract(const Duration(days: 1));

        // Recalcula as listas dentro do Observer e as ordena
        final ongoingTasks = taskStore.observableTasks
            .where((observableTask) =>
                observableTask.type == taskType &&
                observableTask.status == Status.IN_PROGRESS)
            .toList()
          ..sort((a, b) => a.endDate.compareTo(b.endDate));

        final completedTasks = taskStore.observableTasks
            .where((observableTask) =>
                observableTask.type == taskType &&
                observableTask.status == Status.COMPLETED)
            .toList()
          ..sort((a, b) => a.endDate.compareTo(b.endDate));

        // Lista de TODAS as tarefas falhas, ordenadas por data final
        final failedTasks = taskStore.observableTasks
            .where((observableTask) =>
                observableTask.type == taskType &&
                observableTask.status == Status.FAILED)
            .toList()
          ..sort((a, b) => a.endDate.compareTo(b.endDate));

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título da seção
                Text(
                  taskType.namePtBr,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),

                // Seção de tarefas em andamento
                _buildTaskSection('Em Andamento', ongoingTasks, context),

                // Seção de tarefas concluídas
                _buildTaskSection('Concluídas', completedTasks, context),

                // Seção de tarefas falhas (todas)
                _buildTaskSection('Falhas', failedTasks, context),

                // Mensagem se não houver tarefas
                if (ongoingTasks.isEmpty &&
                    completedTasks.isEmpty &&
                    failedTasks.isEmpty)
                  const Center(
                    child: Text('Nenhuma tarefa encontrada.'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget para construir cada seção de tarefas (Em Andamento, Concluídas, Falhas)
  Widget _buildTaskSection(
      String title, List<ObservableTask> tasks, BuildContext context) {
    if (tasks.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        _buildTaskList(context, tasks),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildTaskList(BuildContext context, List<ObservableTask> tasks) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final observableTask = tasks[index];
        return _buildTaskItem(context, observableTask);
      },
    );
  }

  Widget _buildTaskItem(BuildContext context, ObservableTask observableTask) {
    final today = DateTime.now();
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    // Define a cor do ícone com base no tipo e status da tarefa
    Color iconColor =
        taskType == TaskType.PRODUCTIVITY ? Colors.blue : Colors.pinkAccent;
    if (observableTask.status == Status.COMPLETED) {
      iconColor = Colors.green;
    } else if (observableTask.status == Status.FAILED) {
      iconColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskInfoScreen(task: observableTask.task),
            ),
          );
        },
        leading: InkWell(
          onTap: () async {
            // Navega para a tela de seleção de ícones e espera o resultado
            final selectedIcon = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    IconSelectionScreen(task: observableTask.task),
              ),
            ) as String?;

            // Se um ícone foi selecionado, atualiza a tarefa
            if (selectedIcon != null) {
              final updatedTask =
                  observableTask.task.copyWith(icon: selectedIcon);
              taskStore.updateTask(updatedTask);
            }
          },
          child: FutureBuilder<String?>(
            future: IconManager().getLocalIconPath(observableTask.icon ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data != null) {
                // Exibe o ícone baixado se existir
                return Image.file(File(snapshot.data!), height: 30, width: 30);
              } else {
                // Exibe o ícone padrão se não houver um ícone baixado
                return Icon(Icons.task, color: iconColor, size: 30);
              }
            },
          ),
        ),
        title: Text(
          observableTask.title,
          style: TextStyle(
            decoration: observableTask.status != Status.IN_PROGRESS
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: Text(
          '${observableTask.type.namePtBr} - ${observableTask.difficulty.namePtBr}',
          style: TextStyle(
            decoration: observableTask.status != Status.IN_PROGRESS
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (observableTask.status == Status.IN_PROGRESS)
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  taskStore.completeTask(observableTask.task);
                },
              ),
            if (observableTask.status == Status.IN_PROGRESS)
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  taskStore.failTask(observableTask.task);
                },
              ),
            // Botão "Concluir" (apenas para tarefas que falharam Ontem ou hoje)
            if (observableTask.status == Status.FAILED &&
                observableTask.dateFinish != null &&
                ((observableTask.dateFinish!.year == today.year &&
                    observableTask.dateFinish!.month == today.month &&
                    ((observableTask.dateFinish!.day == yesterday.day) ||
                        observableTask.dateFinish!.day == today.day))))
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  taskStore.completeOverdueTask(observableTask.task);
                },
              ),
          ],
        ),
      ),
    );
  }
}
