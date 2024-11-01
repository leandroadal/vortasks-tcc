import 'package:flutter/material.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/screens/tasks/task_tab.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight * 2),
          child: Column(
            children: [
              const MyAppBar(title: 'Tarefas'),
              Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const TabBar(
                  tabs: [
                    Tab(text: 'Produtividade'),
                    Tab(text: 'Bem-estar'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskTab(
              taskType: TaskType.PRODUCTIVITY,
            ),
            TaskTab(
              taskType: TaskType.WELL_BEING,
            ),
          ],
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
