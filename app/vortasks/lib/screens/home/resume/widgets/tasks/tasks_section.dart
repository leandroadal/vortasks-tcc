import 'package:flutter/material.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/tasks/task.dart';
import 'package:vortasks/screens/home/resume/widgets/tasks/task_item.dart';

class TasksSection extends StatelessWidget {
  final String title;
  final List<Task> data;

  const TasksSection(this.title, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 8.0),
        data.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length, // Número total de itens
                itemBuilder: (context, index) {
                  final task = data[index];
                  return TaskItem(
                    icon: Icons.task,
                    label: task.title,
                    task: task,
                  );
                },
              )
            : const Center(
                child: Text(
                  'Não há tarefas desse programadas para esse período',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
      ],
    );
  }

  Color background(BuildContext context, TaskType type) {
    if (type == TaskType.PRODUCTIVITY) {
      return Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 165, 197, 252)
          // Color.fromARGB(255, 108, 150, 233)
          // Color.fromARGB(255, 127, 160, 226
          : const Color.fromARGB(255, 20, 57, 114);
    } else {
      return Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 255, 175, 239)
          : const Color.fromARGB(255, 70, 22, 112);
    }
  }
}
