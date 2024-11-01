import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/social/grouptask/details/group_task_details_screen.dart';
import 'package:vortasks/stores/social/group_task_store.dart';
import 'package:intl/intl.dart';

class AllGroupTasksScreen extends StatefulWidget {
  const AllGroupTasksScreen({super.key});

  @override
  State<AllGroupTasksScreen> createState() => _AllGroupTasksScreenState();
}

class _AllGroupTasksScreenState extends State<AllGroupTasksScreen> {
  final GroupTaskStore groupTaskStore = GetIt.I<GroupTaskStore>();

  @override
  void initState() {
    super.initState();
    groupTaskStore.loadGroupTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as Tarefas em Grupo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Observer(
        builder: (_) {
          final ongoingGroupTasks = groupTaskStore.groupTasks
              .where((task) => task.endDate.isAfter(DateTime.now()))
              .toList()
            ..sort((a, b) => a.endDate.compareTo(b.endDate));

          final completedGroupTasks = groupTaskStore.groupTasks
              .where((task) => task.endDate.isBefore(DateTime.now()))
              .toList()
            ..sort((a, b) => a.endDate.compareTo(b.endDate));

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGroupTaskSection(
                      'Em Andamento', ongoingGroupTasks, context),
                  _buildGroupTaskSection(
                      'Concluídas', completedGroupTasks, context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGroupTaskSection(
      String title, List<dynamic> tasks, BuildContext context) {
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
        _buildGroupTaskList(context, tasks),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildGroupTaskList(BuildContext context, List<dynamic> tasks) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _buildGroupTaskItem(context, task);
      },
    );
  }

  Widget _buildGroupTaskItem(BuildContext context, dynamic task) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupTaskDetailsScreen(groupTask: task),
            ),
          );
        },
        leading: const Icon(Icons.group),
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Autor: ${task.author}'),
            const SizedBox(height: 4),
            Text(
                'Data Final: ${DateFormat('dd/MM/yyyy HH:mm').format(task.endDate)}'),
          ],
        ),
      ),
    );
  }
}
