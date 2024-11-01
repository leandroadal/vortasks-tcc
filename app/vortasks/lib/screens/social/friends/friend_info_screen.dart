// friend_info_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/social/friendship_data.dart';
import 'package:vortasks/screens/social/widgets/social_task_item.dart';
import 'package:vortasks/stores/social/group_task_store.dart';
import 'package:vortasks/stores/user_store.dart';

class FriendInfoScreen extends StatelessWidget {
  final FriendshipData friendData;
  final String friendshipId;

  const FriendInfoScreen({
    super.key,
    required this.friendData,
    required this.friendshipId,
  });

  @override
  Widget build(BuildContext context) {
    final userStore = GetIt.I<UserStore>();
    final groupTaskStore = GetIt.I<GroupTaskStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Amigo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de informações do amigo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                        child: Text(
                      friendData.username,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    const SizedBox(height: 8),
                    Center(
                        child: Text('Level ${friendData.level}',
                            style: const TextStyle(fontSize: 16))),
                    const SizedBox(height: 16),
                    Center(
                        child: Text('Username: ${friendData.username}',
                            style: const TextStyle(fontSize: 16))),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            // Seção de tarefas em grupo compartilhadas
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tarefas em Grupo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                        child: _buildSharedGroupTasksList(
                            context, userStore, groupTaskStore, friendData)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir a lista de tarefas em grupo compartilhadas
  Widget _buildSharedGroupTasksList(BuildContext context, UserStore userStore,
      GroupTaskStore groupTaskStore, FriendshipData friendData) {
    return Observer(
      builder: (_) {
        if (groupTaskStore.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (groupTaskStore.error != null) {
          return Center(
            child: Column(
              children: [
                Text(
                  groupTaskStore.error!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16.0),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 32.0),
                  onPressed: () async => await groupTaskStore.loadGroupTasks(),
                ),
              ],
            ),
          );
        } else {
          final sharedTasks = groupTaskStore.groupTasks.where((task) {
            return task.participants.contains(friendData.username) &&
                task.participants.contains(userStore.username!);
          }).toList();

          if (sharedTasks.isEmpty) {
            return const Center(
                child: Text('Nenhuma tarefa em grupo compartilhada.'));
          } else {
            return ListView.builder(
              itemCount: sharedTasks.length,
              itemBuilder: (context, index) {
                final task = sharedTasks[index];
                return SocialTaskItem(task: task);
              },
            );
          }
        }
      },
    );
  }
}
