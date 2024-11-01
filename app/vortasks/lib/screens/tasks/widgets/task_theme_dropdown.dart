import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vortasks/models/enums/task_theme.dart';
import 'package:vortasks/stores/tasks/task_form_store.dart';

class TaskThemeDropdown extends StatelessWidget {
  final TaskFormStore addTaskStore;

  const TaskThemeDropdown({super.key, required this.addTaskStore});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tema da Tarefa:',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Observer(builder: (_) {
          return DropdownButton<TaskTheme>(
            value: addTaskStore.selectedTaskTheme,
            hint: const Text(
              'Selecione um tema',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (TaskTheme? newValue) {
              addTaskStore.setSelectedTaskTheme(newValue);
            },
            dropdownColor: const Color(0xFF37474F),
            iconEnabledColor: Colors.white,
            items: TaskTheme.values.map((TaskTheme theme) {
              return DropdownMenuItem<TaskTheme>(
                value: theme,
                child: Text(
                  //taskThemeNames[theme]!,
                  theme.namePtBr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
