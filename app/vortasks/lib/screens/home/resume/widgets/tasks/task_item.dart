import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/core/data/Icon_manager.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/exceptions/not_sign_exception.dart';
import 'package:vortasks/models/tasks/task.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';
import 'package:vortasks/screens/home/resume/widgets/tasks/icon_selection_screen.dart';
import 'package:vortasks/screens/tasks/task_info_screen.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class TaskItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Task task;
  final Color? backgroundColor;

  const TaskItem(
      {required this.icon,
      required this.label,
      super.key,
      required this.task,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final TaskStore taskStore = GetIt.I<TaskStore>();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskInfoScreen(task: task),
          ),
        );
      },
      child: Card(
        color: backgroundColor,
        child: ListTile(
          leading: InkWell(
            onTap: () async {
              // Navega para a tela de seleção de ícones e espera o resultado
              final selectedIcon = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IconSelectionScreen(task: task),
                ),
              ) as String?;

              // Se um ícone foi selecionado, atualiza a tarefa
              if (selectedIcon != null) {
                final updatedTask = task.copyWith(icon: selectedIcon);
                taskStore.updateTask(updatedTask);
              }
            },
            child: FutureBuilder<String?>(
              future: IconManager().getLocalIconPath(
                  task.icon ?? ''), // Obtém o caminho do ícone local
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data != null) {
                  // Exibe o ícone baixado se existir
                  return Image.file(File(snapshot.data!),
                      height: 30, width: 30);
                } else {
                  // Exibe o ícone padrão se não houver um ícone baixado
                  return Icon(icon, size: 30);
                }
              },
            ),
          ),
          title: Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  try {
                    taskStore.failTask(task);
                  } on BadTokenException catch (_) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  } on NotSignException catch (e) {
                    handleNotSignException(context, e);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () async {
                  try {
                    await taskStore.completeTask(task);
                  } on BadTokenException catch (_) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  } on NotSignException catch (e) {
                    handleNotSignException(context, e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleNotSignException(BuildContext context, NotSignException e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  e.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0, // Sem sombra
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
