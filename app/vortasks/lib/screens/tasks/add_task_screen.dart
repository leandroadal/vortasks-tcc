import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/tasks/task.dart';
import 'package:vortasks/screens/tasks/widgets/task_button.dart';
import 'package:vortasks/screens/tasks/widgets/task_form.dart';
import 'package:vortasks/stores/tasks/task_form_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.title, required this.type});

  final String title;
  final TaskType type;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final TaskFormStore addTaskStore = GetIt.I<TaskFormStore>();
    addTaskStore.setSelectedType(widget.type.name);
    Color backgroundColor = background(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      backgroundColor: backgroundColor,
      body: TaskForm(
        addTaskStore: addTaskStore,
        addTaskButton: _buildTaskButton(addTaskStore),
      ),
    );
  }

  TaskButton _buildTaskButton(TaskFormStore addTaskStore) {
    return TaskButton(
      selectedType: addTaskStore.selectedType,
      onPressed: () => _addTask(addTaskStore),
      addTaskStore: addTaskStore,
      label: 'Adicionar tarefa',
    );
  }

  Color background(BuildContext context) {
    if (widget.type == TaskType.PRODUCTIVITY) {
      return Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF3674ef)
          : const Color(0xFF0D47A1);
    } else {
      return Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(255, 206, 109, 186)
          : const Color(0xFF9949de);
    }
  }

  void _addTask(TaskFormStore addTaskStore) {
    final TaskStore taskStore = GetIt.I<TaskStore>();

    addTaskStore.setLoading(true);

    if (addTaskStore.isFormValid) {
      final task = _createTaskFromFormData(addTaskStore);
      taskStore.addTask(task);
      addTaskStore.clear();
      Navigator.pop(context);
    } else {
      addTaskStore.setLoading(false);
      _showValidationError(addTaskStore);
    }
  }

  Task _createTaskFromFormData(TaskFormStore addTaskStore) {
    final SkillStore skillStore = GetIt.I<SkillStore>();
    final selectedSkillsObjects = addTaskStore.selectedSkills
        .map((skillId) =>
            skillStore.skills.firstWhere((skill) => skill.id == skillId))
        .toList();

    int xp = _calculateXP(addTaskStore.selectedDifficulty);

    Task task = Task(
      id: generateUUID(),
      title: addTaskStore.title!,
      description: addTaskStore.description ?? '',
      type: TaskType.values.byName(addTaskStore.selectedType),
      status: Status.IN_PROGRESS,
      difficulty: addTaskStore.selectedDifficulty,
      theme: addTaskStore.selectedTaskTheme!,
      startDate: addTaskStore.startDate,
      endDate: addTaskStore.endDate,
      repetition: addTaskStore.selectedRepetition ?? 0,
      reminder: addTaskStore.endDate
          .subtract(Duration(minutes: addTaskStore.selectedReminder ?? 0)),
      xp: xp,
      coins: 100,
      skills: selectedSkillsObjects,
      skillIncrease: xp,
      skillDecrease: (xp / 2).round(),
      finish: false,
    );
    if (kDebugMode) {
      print(task.toJson().toString());
    }
    return task;
  }

  void _showValidationError(TaskFormStore addTaskStore) {
    if (!addTaskStore.isTitleValid) {
      _showCustomErrorSnackBar(
          context, 'Por favor, insira um título para a tarefa');
    } else if (addTaskStore.selectedTaskTheme == null) {
      _showCustomErrorSnackBar(
          context, 'Por favor, selecione um tema para a tarefa');
    } else {
      _showCustomErrorSnackBar(
          context, 'Por favor, selecione uma habilidade para a tarefa');
    }
  }

  void _showCustomErrorSnackBar(BuildContext context, String message) {
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
                  message,
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
        duration: const Duration(seconds: 3),
      ),
    );
  }

  int _calculateXP(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.EASY:
        return (100 * 0.8).toInt(); // Fácil: 80% da XP normal
      case Difficulty.MEDIUM:
        return 100; // Normal: 100 XP
      case Difficulty.HARD:
        return (100 * 1.5).toInt(); // Difícil: 150% da XP normal
      default:
        return 100; // Valor padrão caso a dificuldade não seja reconhecida
    }
  }
}
