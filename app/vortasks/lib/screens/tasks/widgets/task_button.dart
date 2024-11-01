import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/stores/tasks/task_form_store.dart';

Color disabledButtonColor = Colors.grey.withOpacity(0.5);

class TaskButton extends StatelessWidget {
  const TaskButton({
    super.key,
    required this.selectedType,
    required this.onPressed,
    required this.addTaskStore,
    required this.label,
  });

  final String label;
  final String selectedType;
  final VoidCallback? onPressed;
  final TaskFormStore addTaskStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                onPressed != null // Verifica se o botão está habilitado
                    ? selectedType == TaskType.PRODUCTIVITY.name
                        ? const Color.fromARGB(255, 70, 56, 196)
                        : const Color(0XFFAA00FF)
                    : disabledButtonColor, // Cor opaca quando desabilitado
          ),
          onPressed: onPressed,
          child: addTaskStore.loading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : Text(
                  label,
                  style: const TextStyle(color: Colors.white),
                ),
        );
      },
    );
  }
}
