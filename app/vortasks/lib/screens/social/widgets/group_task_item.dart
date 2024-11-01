// social_widgets.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/controllers/social/group_subtask_controller.dart';
import 'package:vortasks/controllers/social/group_task_controller.dart';
import 'package:vortasks/models/social/grouptask.dart';
import 'package:vortasks/screens/social/widgets/subtask_item.dart';
import 'package:vortasks/stores/social/social_store.dart';

class GroupTaskItem extends StatefulWidget {
  final GroupTask groupTask;
  final GroupTaskController groupTaskController;
  final GroupSubtaskController groupSubtaskController;

  const GroupTaskItem({
    super.key,
    required this.groupTask,
    required this.groupTaskController,
    required this.groupSubtaskController,
  });

  @override
  State<GroupTaskItem> createState() => _GroupTaskItemState();
}

class _GroupTaskItemState extends State<GroupTaskItem> {
  bool showAllSubtasks = false;
  final SocialStore socialStore = GetIt.I<SocialStore>();

  @override
  Widget build(BuildContext context) {
    widget.groupTask.groupSubtask
        .sort((a, b) => a.endDate.compareTo(b.endDate));

    return Card(
      color: Theme.of(context).colorScheme.inversePrimary,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.groupTask.title,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            for (int i = 0;
                i <
                        (showAllSubtasks
                            ? widget.groupTask.groupSubtask.length
                            : 2) &&
                    i < widget.groupTask.groupSubtask.length;
                i++)
              SubtaskItem(
                subtask: widget.groupTask.groupSubtask[i],
                groupTask: widget.groupTask,
                groupSubtaskController: widget.groupSubtaskController,
              ),
            if (widget.groupTask.groupSubtask.length > 2)
              TextButton(
                onPressed: () =>
                    setState(() => showAllSubtasks = !showAllSubtasks),
                child: Text(showAllSubtasks ? 'Ver Menos' : 'Ver Mais'),
              ),
            if (widget.groupTask.groupSubtask
                .every((subtask) => subtask.finish == true))
              ElevatedButton(
                onPressed: () async {
                  widget.groupTask.finish = true;
                  widget.groupTask.dateFinish = DateTime.now();
                  try {
                    await widget.groupTaskController
                        .editGroupTask(widget.groupTask);
                    socialStore.todayGroupTasks.remove(widget.groupTask);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Tarefa em grupo concluída!')));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Erro ao concluir a tarefa: $e')));
                  }
                },
                child: const Text('Concluir Tarefa em Grupo'),
              ),
          ],
        ),
      ),
    );
  }
}
