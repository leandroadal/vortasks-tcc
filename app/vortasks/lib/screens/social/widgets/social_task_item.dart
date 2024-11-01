import 'package:flutter/material.dart';
import 'package:vortasks/models/social/grouptask.dart';

class SocialTaskItem extends StatelessWidget {
  final GroupTask task;

  const SocialTaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.inversePrimary,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: const Icon(Icons.image, size: 32.0),
        title: Text(task.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // TODO: Lógica para Falhar na tarefa social
              },
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // TODO: Lógica para completar a tarefa social
              },
            ),
          ],
        ),
      ),
    );
  }
}
