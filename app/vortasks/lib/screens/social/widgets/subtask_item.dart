import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortasks/controllers/social/group_subtask_controller.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/social/group_subtask.dart';
import 'package:vortasks/models/social/grouptask.dart';

class SubtaskItem extends StatelessWidget {
  final GroupSubtask subtask;
  final GroupTask groupTask;
  final GroupSubtaskController groupSubtaskController;

  const SubtaskItem({
    super.key,
    required this.subtask,
    required this.groupTask,
    required this.groupSubtaskController,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subtask.title),
      subtitle: Text(
          'Data Final: ${DateFormat('dd/MM/yyyy HH:mm').format(subtask.endDate)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            subtask.finish == true
                ? subtask.status == Status.COMPLETED
                    ? Icons.check_circle
                    : Icons.close_sharp
                : null,
            color: subtask.finish == true
                ? subtask.status == Status.COMPLETED
                    ? Colors.green
                    : Colors.red
                : Colors.grey,
          ),
          const SizedBox(width: 8.0),
          if (subtask.finish != true)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                subtask.status = Status.COMPLETED;
                subtask.finish = true;
                subtask.dateFinish = DateTime.now();
                try {
                  await groupSubtaskController.editGroupSubtask(
                      groupTask.id, subtask.id, subtask);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Subtarefa concluída!')));
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Erro ao concluir a sub tarefa: $e')));
                }
              },
            ),
          if (subtask.finish != true)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                subtask.status = Status.FAILED;
                subtask.finish = true;
                subtask.dateFinish = DateTime.now();

                try {
                  await groupSubtaskController.editGroupSubtask(
                      groupTask.id, subtask.id, subtask);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Subtarefa definida como falha.')));
                } catch (e) {
                  subtask.status = Status.IN_PROGRESS;
                  subtask.finish = false;
                  subtask.dateFinish = null;
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Erro ao definir a sub tarefa como falha: $e')));
                }
              },
            ),
        ],
      ),
    );
  }
}
