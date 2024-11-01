import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/enums/task_theme.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/social/friendship_data.dart';
import 'package:vortasks/models/social/group_subtask.dart';
import 'package:vortasks/screens/tasks/widgets/date_pickers.dart';
import 'package:vortasks/screens/tasks/widgets/switch_field.dart';
import 'package:vortasks/screens/tasks/widgets/task_form.dart';
import 'package:vortasks/screens/tasks/widgets/time_pickers.dart';
import 'package:vortasks/screens/tasks/widgets/toggle_button_field.dart';
import 'package:vortasks/screens/widgets/custom_textfield.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';

class GroupSubtaskForm extends StatefulWidget {
  final Function(GroupSubtask) onSubmit;
  final GroupSubtask? initialTask;
  final List<FriendshipData>
      friends; // Lista de amigos selecionados na tela anterior

  const GroupSubtaskForm(
      {super.key,
      required this.onSubmit,
      this.initialTask,
      required this.friends});

  @override
  State<GroupSubtaskForm> createState() => _GroupSubtaskFormState();
}

class _GroupSubtaskFormState extends State<GroupSubtaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Status _selectedStatus = Status.IN_PROGRESS;
  int _selectedXp = 100;
  int _selectedCoins = 50;
  TaskType _selectedType = TaskType.PRODUCTIVITY;
  int? _selectedRepetition;
  DateTime _selectedReminder = DateTime.now();
  int _selectedSkillIncrease = 50;
  int _selectedSkillDecrease = 25;
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();
  TaskTheme _selectedTheme = TaskTheme.WELLNESS;
  Difficulty _selectedDifficulty = Difficulty.MEDIUM;
  bool _allDayEnabled = true;
  bool _startDateEnabled = false;
  bool _reminderEnabled = false;
  bool _repetitionEnabled = false;

  // Lista de IDs de habilidades selecionadas
  List<String> _selectedSkillIds = [];

  // Lista de nomes de participantes selecionados
  List<String> _selectedParticipants = [];

  @override
  void initState() {
    super.initState();
    // Se estiver editando, preencha os campos com os dados da tarefa inicial
    if (widget.initialTask != null) {
      _titleController.text = widget.initialTask!.title;
      _descriptionController.text = widget.initialTask!.description ?? '';
      _selectedStatus = widget.initialTask!.status;
      _selectedXp = widget.initialTask!.xp;
      _selectedCoins = widget.initialTask!.coins;
      _selectedType = widget.initialTask!.type;
      _selectedRepetition = widget.initialTask!.repetition;
      _selectedReminder = widget.initialTask!.reminder;
      _selectedSkillIncrease = widget.initialTask!.skillIncrease;
      _selectedSkillDecrease = widget.initialTask!.skillDecrease;
      _selectedStartDate = widget.initialTask!.startDate;
      _selectedEndDate = widget.initialTask!.endDate;
      _selectedTheme = widget.initialTask!.theme;
      _selectedDifficulty = widget.initialTask!.difficulty;
      _allDayEnabled = widget.initialTask!.endDate.hour == 23 &&
          widget.initialTask!.endDate.minute == 59 &&
          widget.initialTask!.endDate.second == 59;
      _startDateEnabled =
          widget.initialTask!.startDate != widget.initialTask!.endDate;
      _reminderEnabled =
          widget.initialTask!.reminder != widget.initialTask!.endDate;
      _repetitionEnabled = widget.initialTask!.repetition != 0;

      _selectedSkillIds = widget.initialTask!.skills.toList();

      _selectedParticipants = widget.initialTask!.participants.toList();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Título',
            colorText: Colors.black,
            borderColor: Colors.grey,
            cursorColor: Colors.black,
            onChanged: (value) {
              _titleController.text = value;
            },
          ),
          CustomTextField(
            label: 'Descrição',
            colorText: Colors.black,
            borderColor: Colors.grey,
            onChanged: (value) => _descriptionController.text = value,
          ),
          const SizedBox(height: 20),
          _buildDifficultySection(),
          const SizedBox(height: 20),
          /*
          TaskThemeDropdown(
            selectedTaskTheme: _selectedTheme,
            onThemeChanged: (newTheme) {
              setState(() {
                _selectedTheme = newTheme;
                // Limpa as habilidades selecionadas quando o tema muda
                _selectedSkillIds.clear();
              });
            },
          ),
          */
          const SizedBox(height: 20),
          _buildSkillDropdown(),
          const SizedBox(height: 20),
          _buildAllDaySection(),
          const SizedBox(height: 20),
          _buildEndTimeField(),
          const SizedBox(height: 20),
          _buildStartDateSection(),
          const SizedBox(height: 20),
          _buildEndDateField(),
          const SizedBox(height: 20),
          _buildRepetitionSection(),
          const SizedBox(height: 20),
          _buildReminderSection(),
          const SizedBox(height: 20),
          _buildParticipantsSection(),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _createIndividualTask();
              }
            },
            child: const Text('Criar Tarefa'),
          ),
        ],
      ),
    );
  }

  Column _buildDifficultySection() {
    return Column(
      children: [
        const Text(
          'Dificuldade',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        ToggleButtonWidget(
          options: const [
            'Fácil',
            'Normal',
            'Difícil',
          ],
          isSelected: [
            _selectedDifficulty == Difficulty.EASY,
            _selectedDifficulty == Difficulty.MEDIUM,
            _selectedDifficulty == Difficulty.HARD,
          ],
          onOptionSelected: (index) {
            setState(() {
              switch (index) {
                case 0:
                  _selectedDifficulty = Difficulty.EASY;
                  break;
                case 1:
                  _selectedDifficulty = Difficulty.MEDIUM;
                  break;
                case 2:
                  _selectedDifficulty = Difficulty.HARD;
                  break;
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildSkillDropdown() {
    return Observer(
      builder: (_) {
        final filteredSkills = GetIt.I<SkillStore>()
            .skills
            .where((skill) => skill.taskThemes.contains(_selectedTheme))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Habilidades Relacionadas:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: filteredSkills.map((skill) {
                return FilterChip(
                  label: Text(
                    skill.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  selectedColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
                  selected: _selectedSkillIds.contains(skill.id),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedSkillIds.add(skill.id);
                      } else {
                        _selectedSkillIds.remove(skill.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  SwitchField _buildAllDaySection() {
    return SwitchField(
      title: 'Dia Inteiro',
      value: _allDayEnabled,
      onChanged: (value) => setState(() {
        _allDayEnabled = value;
        if (_allDayEnabled) {
          DateTime newEndDate = _selectedEndDate.subtract(Duration(
            hours: _selectedEndDate.hour,
            minutes: _selectedEndDate.minute,
            seconds: _selectedEndDate.second,
          ));
          _selectedEndDate =
              newEndDate.add(const Duration(hours: 23, minutes: 59));
        }
      }),
    );
  }

  Widget _buildEndTimeField() {
    if (!_allDayEnabled) {
      return TimePickerField(
        label: 'Hora do Término',
        initialTime: _selectedEndDate,
        onTimeChanged: (time) => setState(() {
          _selectedEndDate = DateTime(
            _selectedEndDate.year,
            _selectedEndDate.month,
            _selectedEndDate.day,
            time.hour,
            time.minute,
          );
        }),
        enabled: !_allDayEnabled,
      );
    } else {
      return Container();
    }
  }

  Column _buildStartDateSection() {
    return Column(
      children: [
        SwitchField(
          title: 'Data de Início',
          value: _startDateEnabled,
          onChanged: (value) => setState(() => _startDateEnabled = value),
        ),
        if (_startDateEnabled)
          DatePickerField(
            initialDate: _selectedStartDate,
            onDateChanged: (date) => setState(() => _selectedStartDate = date),
            enabled: _startDateEnabled,
          ),
      ],
    );
  }

  DatePickerField _buildEndDateField() {
    return DatePickerField(
      label: 'Data de Termino:',
      initialDate: _selectedEndDate,
      onDateChanged: (date) => setState(() => _selectedEndDate = date),
    );
  }

  Column _buildRepetitionSection() {
    return Column(
      children: [
        SwitchField(
          title: 'Repetição',
          onChanged: (value) => setState(() => _repetitionEnabled = value),
          value: _repetitionEnabled,
        ),
        if (_repetitionEnabled)
          ToggleButtonWidget(
            options: const ['Diária', 'Semanal', 'Mensal'],
            isSelected: [
              _selectedRepetition == 1,
              _selectedRepetition == 7,
              _selectedRepetition == 30
            ],
            onOptionSelected: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    _selectedRepetition = 1;
                    break;
                  case 1:
                    _selectedRepetition = 7;
                    break;
                  case 2:
                    _selectedRepetition = 30;
                    break;
                }
              });
            },
          ),
      ],
    );
  }

  Column _buildReminderSection() {
    return Column(
      children: [
        SwitchField(
          title: 'Lembrete',
          onChanged: (value) => setState(() => _reminderEnabled = value),
          value: _reminderEnabled,
        ),
        if (_reminderEnabled)
          ToggleButtonWidget(
            options: const ['10min', '1h', '1d'],
            isSelected: [
              _selectedReminder ==
                  _selectedEndDate.subtract(const Duration(minutes: 10)),
              _selectedReminder ==
                  _selectedEndDate.subtract(const Duration(hours: 1)),
              _selectedReminder ==
                  _selectedEndDate.subtract(const Duration(days: 1)),
            ],
            onOptionSelected: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    _selectedReminder =
                        _selectedEndDate.subtract(const Duration(minutes: 10));
                    break;
                  case 1:
                    _selectedReminder =
                        _selectedEndDate.subtract(const Duration(hours: 1));
                    break;
                  case 2:
                    _selectedReminder =
                        _selectedEndDate.subtract(const Duration(days: 1));
                    break;
                }
              });
            },
          ),
      ],
    );
  }

  Widget _buildParticipantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Adicionar Participantes:',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        _buildParticipantChips(),
      ],
    );
  }

  Widget _buildParticipantChips() {
    return Wrap(
      spacing: 8.0,
      children: widget.friends.map((friend) {
        return FilterChip(
          label: Text(friend.username),
          selected: _selectedParticipants.contains(friend.username),
          selectedColor: Theme.of(context).colorScheme.primary,
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
    );
  }

  void _createIndividualTask() {
    if (_formKey.currentState!.validate()) {
      final newSubtask = GroupSubtask(
        id: generateUUID(),
        title: _titleController.text,
        description: _descriptionController.text,
        status: _selectedStatus,
        xp: _selectedXp,
        coins: _selectedCoins,
        type: _selectedType,
        repetition: _selectedRepetition ?? 0,
        reminder: _selectedReminder,
        skillIncrease: _selectedSkillIncrease,
        skillDecrease: _selectedSkillDecrease,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
        theme: _selectedTheme,
        difficulty: _selectedDifficulty,
        finish: false,
        skills: _selectedSkillIds.toSet(),
        participants: _selectedParticipants,
      );

      // Chama a função onSubmit para adicionar a tarefa à lista na tela anterior
      widget.onSubmit(newSubtask);
    }
  }
}
