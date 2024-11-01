import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/controllers/social/group_task_controller.dart';
import 'package:vortasks/controllers/social/group_task_invite_controller.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/social/friendship_data.dart';
import 'package:vortasks/models/social/grouptask.dart';
import 'package:vortasks/models/social/group_subtask.dart';
import 'package:vortasks/screens/auth/login/login_screen.dart';
import 'package:vortasks/screens/auth/widgets/error_box.dart';
import 'package:vortasks/screens/tasks/widgets/date_pickers.dart';
import 'package:vortasks/screens/tasks/widgets/task_button.dart';
import 'package:vortasks/screens/tasks/widgets/task_form.dart';
import 'package:vortasks/screens/tasks/widgets/time_pickers.dart';
import 'package:vortasks/screens/widgets/custom_textfield.dart';
import 'package:vortasks/stores/social/group_task_store.dart';
import 'package:vortasks/stores/social/social_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';
import 'package:vortasks/stores/social/friend_store.dart';
import 'package:vortasks/stores/tasks/task_form_store.dart';
import 'package:vortasks/stores/user_store.dart';

class CreateGroupTaskScreen extends StatefulWidget {
  const CreateGroupTaskScreen({super.key});

  @override
  State<CreateGroupTaskScreen> createState() => _CreateGroupTaskScreenState();
}

class _CreateGroupTaskScreenState extends State<CreateGroupTaskScreen> {
  final GroupTaskController _groupTaskController = GroupTaskController();
  final GroupTaskInviteController _inviteController =
      GroupTaskInviteController();
  final TaskFormStore _taskFormStore = GetIt.I<TaskFormStore>();
  final UserStore _userStore = GetIt.I<UserStore>();
  final GroupTaskStore _groupTaskStore = GetIt.I<GroupTaskStore>();
  final FriendStore _friendStore = GetIt.I<FriendStore>();
  final SocialStore _socialStore = GetIt.I<SocialStore>();
  final _formKey = GlobalKey<FormState>();
  final SkillStore _skillStore = GetIt.I<SkillStore>();

  // Lista de amigos selecionados para a tarefa em grupo
  final List<FriendshipData> _selectedFriends = [];

  // Lista de editores selecionados
  final List<String> _selectedEditors = [];

  // Lista de sub tarefas
  final List<GroupSubtask> _groupSubtasks = [];

  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();

  late ReactionDisposer _friendDisposer;
  late ReactionDisposer _loginDisposer;

  get onPrimaryColor => Theme.of(context).colorScheme.onPrimaryContainer;

  @override
  void initState() {
    super.initState();

    _groupTaskStore.error = null;

    _friendDisposer =
        reaction((_) => _friendStore.friendships.isEmpty, (isEmpty) {
      if (isEmpty &&
          _friendStore.isLoading == false &&
          _friendStore.error == null) {
        _showNoFriendsDialog(context);
      }
    });

    _loginDisposer = reaction((_) => _userStore.isLoggedIn, (isLogged) {
      if (!isLogged && mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });

    _friendStore.loadFriends();
  }

  @override
  void dispose() {
    _taskFormStore.clear();
    _friendDisposer();
    _loginDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Tarefa em Grupo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTitleField(),
                _buildDescriptionField(),
                const SizedBox(height: 20),
                _buildStartDatePicker(),
                const SizedBox(height: 20),
                _buildEndDatePicker(),
                const SizedBox(height: 20),
                _buildFriendSelectionSection(),
                const SizedBox(height: 20),
                _buildEditorSection(),
                const SizedBox(height: 20),
                _buildGroupSubtasksSection(),
                const SizedBox(height: 30),
                _buildCreateTaskButton(),
                const SizedBox(height: 20),
                Observer(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ErrorBox(
                      message: _groupTaskStore.error,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Observer _buildTitleField() {
    return Observer(builder: (_) {
      return CustomTextField(
        label: 'Título',
        colorText: onPrimaryColor,
        borderColor: Theme.of(context).colorScheme.onPrimaryContainer,
        cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
        errorText: _taskFormStore.titleError,
        onChanged: (value) {
          _taskFormStore.setTitle(value);
        },
      );
    });
  }

  CustomTextField _buildDescriptionField() {
    return CustomTextField(
      label: 'Descrição (Opcional)',
      colorText: Theme.of(context).colorScheme.onPrimaryContainer,
      borderColor: Theme.of(context).colorScheme.onPrimaryContainer,
      onChanged: (value) => _taskFormStore.setDescription(value),
    );
  }

  Widget _buildStartDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data de Início:',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        DatePickerField(
          colorText: onPrimaryColor,
          borderColor: onPrimaryColor,
          initialDate: _selectedStartDate,
          onDateChanged: (date) => setState(() => _selectedStartDate = date),
        ),
      ],
    );
  }

  Widget _buildEndDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data de Término:',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DatePickerField(
                colorText: onPrimaryColor,
                borderColor: onPrimaryColor,
                initialDate: _selectedEndDate,
                onDateChanged: (date) =>
                    setState(() => _selectedEndDate = date),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TimePickerField(
                label: 'Hora:',
                colorText: onPrimaryColor,
                borderColor: onPrimaryColor,
                initialTime: _selectedEndDate,
                onTimeChanged: (time) {
                  setState(() {
                    _selectedEndDate = DateTime(
                      _selectedEndDate.year,
                      _selectedEndDate.month,
                      _selectedEndDate.day,
                      time.hour,
                      time.minute,
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFriendSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adicionar Amigos à Tarefa:',
          style: TextStyle(
            color: onPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Observer(
          builder: (_) {
            if (_friendStore.isLoading) {
              return const CircularProgressIndicator();
            } else if (_friendStore.error != null) {
              return Text('Erro: ${_friendStore.error}');
            } else if (_friendStore.friendships.isEmpty) {
              return const Center(
                child: Text('Você ainda não tem amigos.'),
              );
            } else {
              return _buildFriendChips(_friendStore.friendships
                  .map((friendship) => friendship.users
                      .firstWhere((user) => user.id != _userStore.user!.id))
                  .toList());
            }
          },
        ),
      ],
    );
  }

  Widget _buildFriendChips(List<FriendshipData> friends) {
    return Wrap(
      spacing: 8.0,
      children: friends.map((friend) {
        return FilterChip(
          label: Text(friend.username),
          selected: _selectedFriends.contains(friend),
          selectedColor: Theme.of(context).colorScheme.primary,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedFriends.add(friend);
              } else {
                _selectedFriends.remove(friend);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildEditorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adicionar Editores (apenas amigos selecionados):',
          style: TextStyle(
            color: onPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        _buildEditorChips(),
      ],
    );
  }

  Widget _buildEditorChips() {
    return Wrap(
      spacing: 8.0,
      children: _selectedFriends.map((friend) {
        return FilterChip(
          label: Text(friend.username),
          selected: _selectedEditors.contains(friend.username),
          selectedColor: Theme.of(context).colorScheme.primary,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedEditors.add(friend.username);
              } else {
                _selectedEditors.remove(friend.username);
              }
            });
          },
        );
      }).toList(),
    );
  }

  // Seção de Tarefas Individuais, agora usando TaskForm
  Widget _buildGroupSubtasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tarefas Individuais (apenas amigos selecionados):',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: onPrimaryColor,
          ),
        ),
        const SizedBox(height: 16.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _groupSubtasks.length,
          itemBuilder: (context, index) {
            return _buildGroupSubtaskItem(_groupSubtasks[index], index);
          },
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            _showCreateGroupSubtaskDialog(context);
          },
          child: const Text('Adicionar Tarefa Individual'),
        ),
      ],
    );
  }

  Widget _buildGroupSubtaskItem(GroupSubtask task, int index) {
    return Card(
      color: Colors.indigo[700],
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(task.title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(task.description ?? '',
            style: const TextStyle(color: Colors.white)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                _showEditGroupSubtaskDialog(context, index);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                setState(() {
                  _groupSubtasks.removeAt(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Observer _buildCreateTaskButton() {
    return Observer(builder: (_) {
      return TaskButton(
        selectedType: _taskFormStore.selectedType,
        onPressed: _taskFormStore.isTitleValid &&
                !_groupTaskStore.isLoading &&
                _groupSubtasks.isNotEmpty
            ? () => _createGroupTask(context)
            : null,
        addTaskStore: _taskFormStore,
        label: 'Criar Tarefa em Grupo',
      );
    });
  }

  void _showCreateGroupSubtaskDialog(BuildContext context) {
    final subtaskFormStore = TaskFormStore();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.indigo[300]
              : Colors.indigo[700],
          title: const Text('Criar Tarefa Individual'),
          content: SingleChildScrollView(
            child: TaskForm(
              addTaskStore: subtaskFormStore,
              addTaskButton: TaskButton(
                selectedType: subtaskFormStore.selectedType,
                onPressed: () {
                  if (subtaskFormStore.isFormValid) {
                    setState(() {
                      _groupSubtasks
                          .add(_createSubtaskFromFormData(subtaskFormStore));
                    });
                    Navigator.of(context).pop();
                  } else {
                    _showValidationError(subtaskFormStore);
                  }
                },
                addTaskStore: subtaskFormStore,
                label: 'Adicionar',
              ),
              backgroundColor: Colors.transparent,
              showParticipants: true,
              selectedFriends: _selectedFriends,
            ),
          ),
        );
      },
    );
  }

  void _showEditGroupSubtaskDialog(BuildContext context, int index) {
    final taskToEdit = _groupSubtasks[index];
    final editTaskFormStore = TaskFormStore()
      ..setTitle(taskToEdit.title)
      ..setDescription(taskToEdit.description ?? '')
      ..setSelectedType(taskToEdit.type.name)
      ..setSelectedDifficulty(taskToEdit.difficulty)
      ..setSelectedTaskTheme(taskToEdit.theme)
      ..selectedSkills.addAll(taskToEdit.skills)
      ..switchAllDayEnabled(taskToEdit.endDate.hour == 23 &&
          taskToEdit.endDate.minute == 59 &&
          taskToEdit.endDate.second == 59)
      ..setStartDateEnabled(taskToEdit.startDate != taskToEdit.endDate)
      ..setStartDate(taskToEdit.startDate)
      ..setEndDate(taskToEdit.endDate)
      ..setRepetitionEnabled(taskToEdit.repetition != 0)
      ..setSelectedRepetition(taskToEdit.repetition)
      ..setReminderEnabled(taskToEdit.reminder != taskToEdit.endDate)
      ..setSelectedReminder(
          taskToEdit.endDate.difference(taskToEdit.reminder).inMinutes)
      ..selectedParticipants = ObservableList.of(taskToEdit.participants);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Tarefa Individual'),
          content: SingleChildScrollView(
            child: TaskForm(
              addTaskStore: editTaskFormStore,
              addTaskButton: TaskButton(
                selectedType: editTaskFormStore.selectedType,
                onPressed: () {
                  if (editTaskFormStore.isFormValid) {
                    setState(() {
                      _groupSubtasks[index] =
                          _createSubtaskFromFormData(editTaskFormStore);
                    });
                    Navigator.of(context).pop();
                  }
                },
                addTaskStore: editTaskFormStore,
                label: 'Salvar',
              ),
              backgroundColor: Colors.transparent,
              showParticipants: true,
              selectedFriends: _selectedFriends,
            ),
          ),
        );
      },
    );
  }

  void _createGroupTask(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      List<String> users =
          _selectedFriends.map((friend) => friend.username).toList();

      final groupTaskId = generateUUID();
      final newGroupTask = GroupTask(
        id: groupTaskId,
        title: _taskFormStore.title!,
        description: _taskFormStore.description,
        author: _userStore.username!,
        editors: _selectedEditors,
        participants: users,
        createdAt: DateTime.now().toUtc(),
        groupSubtask: _groupSubtasks,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
        finish: false,
      );
      try {
        final createdGroupTask =
            await _groupTaskController.createGroupTask(newGroupTask);

        await _inviteController.createInvites(createdGroupTask.id,
            _selectedFriends.map((friend) => friend.username).toList());

        await _socialStore.loadTodayGroupTasks();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tarefa em grupo criada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }

        _taskFormStore.clear();
        _selectedEditors.clear();
        _selectedFriends.clear();
        _groupSubtasks.clear();
        await _groupTaskStore.loadGroupTasks();
        Navigator.pop(context);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Erro ao criar a tarefa: ${e.toString()}',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  GroupSubtask _createSubtaskFromFormData(TaskFormStore taskFormStore) {
    int xp = _calculateXP(taskFormStore.selectedDifficulty);

    // Obtém os nomes das skills selecionadas como um Set<String>
    final selectedSkillNames = taskFormStore.selectedSkills
        .map((skillId) =>
            _skillStore.skills.firstWhere((skill) => skill.id == skillId).name)
        .toSet();

    GroupSubtask groupSubtask = GroupSubtask(
      id: generateUUID(),
      title: taskFormStore.title!,
      description: taskFormStore.description ?? '',
      type: TaskType.values.byName(taskFormStore.selectedType),
      status: Status.IN_PROGRESS,
      difficulty: taskFormStore.selectedDifficulty,
      theme: taskFormStore.selectedTaskTheme!,
      startDate: taskFormStore.startDate,
      endDate: taskFormStore.endDate,
      repetition: taskFormStore.selectedRepetition ?? 0,
      reminder: taskFormStore.endDate
          .subtract(Duration(minutes: taskFormStore.selectedReminder ?? 0)),
      xp: xp,
      coins: 100,
      skills: selectedSkillNames,
      skillIncrease: xp,
      skillDecrease: (xp / 2).round(),
      finish: false,
      participants: taskFormStore.selectedParticipants.toList(),
    );

    return groupSubtask;
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
        elevation: 0,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  int _calculateXP(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.EASY:
        return (100 * 0.8).toInt();
      case Difficulty.MEDIUM:
        return 100;
      case Difficulty.HARD:
        return (100 * 1.5).toInt();
      default:
        return 100;
    }
  }

  void _showNoFriendsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sem Amigos'),
          content: const Text(
              'Você ainda não possui amigos para criar uma tarefa em grupo. Adicione amigos na tela Social.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Fecha a tela atual
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
