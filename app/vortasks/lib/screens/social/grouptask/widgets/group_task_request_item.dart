import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/controllers/social/group_task_controller.dart';
import 'package:vortasks/stores/social/group_task_invite_store.dart';
import 'package:vortasks/models/social/group_task_invite.dart';

class GroupTaskRequestItem extends StatelessWidget {
  final GroupTaskInvite invite;
  final Color? color;
  final Color? backgroundColor;

  const GroupTaskRequestItem(
      {super.key, required this.invite, this.color, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final inviteStore = GetIt.I<GroupTaskInviteStore>();

    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.group, color: Colors.white),
        ),
        title: FutureBuilder(
          future: GroupTaskController().getGroupTaskById(invite.groupTaskId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else {
              final groupTask = snapshot.data;
              return Text(
                groupTask?.title ?? 'Tarefa não encontrada',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: color),
              onPressed: () async {
                await inviteStore.acceptInvite(invite.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.close, color: color),
              onPressed: () async {
                await inviteStore.rejectInvite(invite.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
