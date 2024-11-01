import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vortasks/controllers/social/group_subtask_controller.dart';
import 'package:vortasks/controllers/social/group_task_controller.dart';
import 'package:vortasks/screens/social/widgets/group_task_item.dart';
import 'package:vortasks/stores/social/social_store.dart';

class TodayGroupTasksList extends StatelessWidget {
  final SocialStore socialStore;

  const TodayGroupTasksList({super.key, required this.socialStore});

  @override
  Widget build(BuildContext context) {
    final groupTaskController = GroupTaskController();
    final groupSubtaskController = GroupSubtaskController();
    return Observer(
      builder: (_) {
        if (socialStore.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (socialStore.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    socialStore.setError(null);
                    socialStore.loadTodayGroupTasks();
                  },
                  icon: const Icon(Icons.refresh, size: 48.0),
                ),
                const SizedBox(height: 16.0),
                Text(socialStore.error!,
                    style: const TextStyle(color: Colors.red)),
              ],
            ),
          );
        } else if (socialStore.todayGroupTasks.isEmpty) {
          return const Center(
              child: Text('Você não tem tarefas em grupo para hoje.'));
        } else {
          return ListView.builder(
            itemCount: socialStore.todayGroupTasks.length,
            itemBuilder: (context, index) => GroupTaskItem(
              groupTask: socialStore.todayGroupTasks[index],
              groupTaskController: groupTaskController,
              groupSubtaskController: groupSubtaskController,
            ),
          );
        }
      },
    );
  }
}
