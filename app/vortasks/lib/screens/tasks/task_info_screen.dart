import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/tasks/task.dart';
import 'package:vortasks/screens/tasks/edit_task_screen.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class TaskInfoScreen extends StatelessWidget {
  final Task task;

  const TaskInfoScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskStore taskStore = GetIt.I<TaskStore>();
    final backgroundColor = background(context, task.type);

    return Scaffold(
      backgroundColor: backgroundColor.withAlpha(240),
      appBar: AppBar(
        title: const Text('Info. da Tarefa'),
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                          task: task,
                          backgroundColor: backgroundColor,
                        )),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Excluir Tarefa'),
                    content: const Text(
                        'Tem certeza de que deseja excluir esta tarefa?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          taskStore.deleteTask(task.id);
                          Navigator.of(context).pop(); // Fecha o diálogo
                          Navigator.of(context)
                              .pop(); // Volta para a tela anterior
                        },
                        child: const Text('Excluir'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTaskInfoRow('Título:', task.title, Icons.title),
                  _buildTaskInfoRow(
                      'Descrição:', task.description, Icons.description),
                  _buildTaskInfoRow(
                      'Tipo:', task.type.namePtBr, Icons.category),
                  _buildTaskInfoRow(
                      'Tema:', task.theme.namePtBr, Icons.palette),
                  _buildTaskInfoRow(
                      'Dificuldade:',
                      difficultyToString(task.difficulty),
                      Icons.fitness_center),
                  _buildTaskInfoRow(
                      'Status:', task.status.namePtBr, Icons.info),
                  _buildTaskInfoRow('XP:', task.xp.toString(), Icons.star),
                  _buildTaskInfoRow(
                      'Moedas:', task.coins.toString(), Icons.monetization_on),
                  _buildTaskInfoRow(
                      'Data Inicial:',
                      '${task.startDate.day.toString().padLeft(2, '0')}/${task.startDate.month.toString().padLeft(2, '0')}/${task.startDate.year} às ${task.startDate.hour}:${task.startDate.minute.toString().padLeft(2, '0')}',
                      Icons.calendar_today),
                  _buildTaskInfoRow(
                      'Data Final:',
                      '${task.endDate.day.toString().padLeft(2, '0')}/${task.endDate.month.toString().padLeft(2, '0')}/${task.endDate.year} às ${task.endDate.hour}:${task.endDate.minute.toString().padLeft(2, '0')}',
                      Icons.calendar_today),
                  _buildTaskInfoRow(
                      'Repetição:',
                      task.repetition > 0
                          ? 'A cada ${task.repetition} dias'
                          : 'Não se repete',
                      Icons.repeat),
                  _buildTaskInfoRow(
                      'Lembrete:',
                      '${task.reminder.day.toString().padLeft(2, '0')}/${task.reminder.month.toString().padLeft(2, '0')}/${task.reminder.year} às ${task.reminder.hour}:${task.reminder.minute.toString().padLeft(2, '0')}',
                      Icons.alarm),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Habilidades:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: task.skills.map((skill) {
                      return Chip(label: Text(skill.name));
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Observer(builder: (_) {
            return Text(
              '$label $value',
              style: const TextStyle(fontSize: 16.0),
            );
          }),
        ],
      ),
    );
  }

  String difficultyToString(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.EASY:
        return "Fácil";
      case Difficulty.MEDIUM:
        return "Médio";
      case Difficulty.HARD:
        return "Difícil";
      case Difficulty.VERY_HARD:
        return "Muito Difícil";
      default:
        return "Desconhecido";
    }
  }

  Color background(BuildContext context, TaskType type) {
    if (type == TaskType.PRODUCTIVITY) {
      return Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 165, 197, 252)
          : const Color.fromARGB(255, 20, 57, 114);
    } else {
      return Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 255, 175, 239)
          : const Color.fromARGB(255, 81, 18, 136);
    }
  }
}
