import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:uuid/uuid.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/social/friendship_data.dart';
import 'package:vortasks/screens/widgets/custom_textfield.dart';
import 'package:vortasks/screens/tasks/widgets/task_button.dart';
import 'package:vortasks/screens/tasks/widgets/skill_dropdown.dart';
import 'package:vortasks/screens/tasks/widgets/switch_field.dart';
import 'package:vortasks/screens/tasks/widgets/task_theme_dropdown.dart';
import 'package:vortasks/screens/tasks/widgets/time_pickers.dart';
import 'package:vortasks/screens/tasks/widgets/toggle_button_field.dart';
import 'package:vortasks/stores/tasks/task_form_store.dart';

import 'date_pickers.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({
    super.key,
    required this.addTaskStore,
    required this.addTaskButton,
    this.backgroundColor,
    this.showParticipants = false,
    this.selectedFriends = const <FriendshipData>[],
  });

  final TaskFormStore addTaskStore;
  final TaskButton addTaskButton;
  final Color? backgroundColor;
  final bool showParticipants;
  final List<FriendshipData> selectedFriends;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  List<String> _selectedParticipants = [];

  @override
  void initState() {
    super.initState();
    // Se for uma tarefa em grupo, preencha a lista de participantes com os amigos selecionados
    if (widget.showParticipants) {
      _selectedParticipants =
          widget.selectedFriends.map((friend) => friend.username).toList();
    }
  }

  @override
  void dispose() {
    final TaskFormStore addTaskStore = widget.addTaskStore;
    addTaskStore.clear(); // Limpa os campos do AddTaskStore
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskFormStore addTaskStore = widget.addTaskStore;
    return SingleChildScrollView(
      child: Container(
        color: widget.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitleField(addTaskStore),
              _buildDescriptionField(addTaskStore),
              const SizedBox(height: 20),
              _buildDifficultySection(addTaskStore),
              const SizedBox(height: 20),
              _buildTaskThemeDropdown(addTaskStore),
              const SizedBox(height: 20),
              _buildSkillDropdown(addTaskStore),
              const SizedBox(height: 20),
              _buildAllDaySection(addTaskStore),
              const SizedBox(height: 20),
              _buildEndTimeField(addTaskStore),
              const SizedBox(height: 20),
              _buildStartDateSection(addTaskStore),
              const SizedBox(height: 20),
              _buildEndDateField(addTaskStore),
              const SizedBox(height: 20),
              _buildRepetitionSection(addTaskStore),
              const SizedBox(height: 20),
              _buildReminderSection(addTaskStore),
              // Seção de participantes, visível apenas para tarefas em grupo
              if (widget.showParticipants) ...[
                const SizedBox(height: 20),
                _buildParticipantsSection(addTaskStore),
              ],
              const SizedBox(height: 30),
              _buildAddTaskButton(addTaskStore)
            ],
          ),
        ),
      ),
    );
  }

  Observer _buildTitleField(TaskFormStore addTaskStore) {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'Título',
        colorText: Colors.white,
        borderColor: Colors.white,
        cursorColor: Colors.white,
        errorText: addTaskStore.titleError,
        onChanged: (value) {
          addTaskStore.setTitle(value);
        },
      );
    });
  }

  CustomTextField _buildDescriptionField(TaskFormStore addTaskStore) {
    return CustomTextField(
      label: 'Descrição',
      colorText: Colors.white,
      borderColor: Colors.white,
      onChanged: (value) => addTaskStore.setDescription(value),
    );
  }

  Column _buildDifficultySection(TaskFormStore addTaskStore) {
    return Column(
      children: [
        const Text(
          'Dificuldade',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Observer(builder: (_) {
          return ToggleButtonWidget(
            options: const [
              'Fácil',
              'Normal',
              'Difícil',
            ],
            isSelected: [
              addTaskStore.selectedDifficulty == Difficulty.EASY,
              addTaskStore.selectedDifficulty == Difficulty.MEDIUM,
              addTaskStore.selectedDifficulty == Difficulty.HARD,
            ],
            onOptionSelected: (index) {
              switch (index) {
                case 0:
                  addTaskStore.setSelectedDifficulty(Difficulty.EASY);
                  break;
                case 1:
                  addTaskStore.setSelectedDifficulty(Difficulty.MEDIUM);
                  break;
                case 2:
                  addTaskStore.setSelectedDifficulty(Difficulty.HARD);
                  break;
              }
            },
          );
        }),
      ],
    );
  }

  TaskThemeDropdown _buildTaskThemeDropdown(TaskFormStore addTaskStore) {
    return TaskThemeDropdown(
      addTaskStore: addTaskStore,
    );
  }

  Observer _buildSkillDropdown(TaskFormStore addTaskStore) {
    return Observer(
      builder: (_) {
        if (addTaskStore.selectedTaskTheme != null) {
          return SkillDropdown(addTaskStore: addTaskStore);
        } else {
          return Container();
        }
      },
    );
  }

  Observer _buildAllDaySection(TaskFormStore addTaskStore) {
    return Observer(builder: (_) {
      return Column(
        children: [
          buildSwitchDecoration(
            SwitchField(
              title: 'Dia Inteiro',
              value: addTaskStore.allDayEnabled,
              onChanged: (value) => addTaskStore.switchAllDayEnabled(value),
            ),
          ),
          if (!addTaskStore.allDayEnabled) const SizedBox(height: 10),
        ],
      );
    });
  }

  Observer _buildEndTimeField(TaskFormStore addTaskStore) {
    return Observer(builder: (_) {
      if (!addTaskStore.allDayEnabled) {
        return Column(
          children: [
            TimePickerField(
              label: 'Hora do Término',
              initialTime: addTaskStore.endDate,
              onTimeChanged: (time) => addTaskStore.setEndDate(time),
              enabled: !addTaskStore
                  .allDayEnabled, // Desabilita se 'dia inteiro' estiver ativo
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Column _buildStartDateSection(TaskFormStore addTaskStore) {
    return Column(
      children: [
        Observer(builder: (_) {
          return SwitchField(
            title: 'Data de Início',
            value: addTaskStore.startDateEnabled,
            onChanged: (value) => addTaskStore.setStartDateEnabled(value),
          );
        }),
        Observer(builder: (_) {
          if (addTaskStore.startDateEnabled) {
            return DatePickerField(
              //label: 'Data de Início:',
              initialDate: addTaskStore.startDate,
              onDateChanged: (date) => addTaskStore.setStartDate(date),
              enabled: addTaskStore
                  .startDateEnabled, // controla se o campo está habilitado
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }

  Observer _buildEndDateField(TaskFormStore addTaskStore) {
    return Observer(builder: (_) {
      return DatePickerField(
        label: 'Data de Termino:',
        initialDate: addTaskStore.endDate,
        onDateChanged: (date) => addTaskStore.setEndDate(date),
      );
    });
  }

  Column _buildRepetitionSection(TaskFormStore addTaskStore) {
    return Column(
      children: [
        Observer(builder: (_) {
          return SwitchField(
            title: 'Repetição',
            onChanged: (value) => addTaskStore.setRepetitionEnabled(value),
            value: addTaskStore.repetitionEnabled,
          );
        }),
        Observer(builder: (_) {
          if (addTaskStore.repetitionEnabled) {
            return ToggleButtonWidget(
              options: const ['Diária', 'Semanal', 'Mensal'],
              isSelected: [
                // se for igual retorna true deixando a opção selecionada
                addTaskStore.selectedRepetition == 1,
                addTaskStore.selectedRepetition == 7,
                addTaskStore.selectedRepetition == 30
              ],
              onOptionSelected: (index) {
                switch (index) {
                  case 0:
                    addTaskStore.setSelectedRepetition(1);
                    break;
                  case 1:
                    addTaskStore.setSelectedRepetition(7);
                    break;
                  case 2:
                    addTaskStore.setSelectedRepetition(30);
                    break;
                }
              },
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }

  Column _buildReminderSection(TaskFormStore addTaskStore) {
    return Column(
      children: [
        Observer(builder: (_) {
          return SwitchField(
            title: 'Lembrete',
            onChanged: (value) => addTaskStore.setReminderEnabled(value),
            value: addTaskStore.reminderEnabled,
          );
        }),
        Observer(builder: (_) {
          if (addTaskStore.reminderEnabled) {
            return ToggleButtonWidget(
              options: const ['10min', '1h', '1d'],
              isSelected: [
                // se for igual retorna true deixando a opção selecionada
                addTaskStore.selectedReminder == 10,
                addTaskStore.selectedReminder == 60,
                addTaskStore.selectedReminder == 1440
              ],
              onOptionSelected: (index) {
                switch (index) {
                  case 0:
                    addTaskStore.setSelectedReminder(10);
                    break;
                  case 1:
                    addTaskStore.setSelectedReminder(60);
                    break;
                  case 2:
                    addTaskStore.setSelectedReminder(1440);
                    break;
                }
              },
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }

  Widget _buildAddTaskButton(TaskFormStore addTaskStore) {
    return widget.addTaskButton;
  }

  Container buildSwitchDecoration(SwitchField switcher) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white70),
        ),
        child: switcher);
  }

  // Seção de participantes (visível apenas para tarefas em grupo)
  Widget _buildParticipantsSection(TaskFormStore addTaskStore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Participantes:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children: widget.selectedFriends.map((friend) {
            return FilterChip(
              label: Text(
                friend.username,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              selected: _selectedParticipants.contains(friend.username),
              backgroundColor: Theme.of(context).colorScheme.primary,
              selectedColor:
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedParticipants.add(friend.username);
                  } else {
                    _selectedParticipants.remove(friend.username);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

String generateUUID() {
  var uuid = const Uuid();
  return uuid.v4();
}
