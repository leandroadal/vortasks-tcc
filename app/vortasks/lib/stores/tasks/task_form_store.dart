import 'package:mobx/mobx.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/enums/task_theme.dart';
import 'package:vortasks/models/enums/task_type.dart';
part 'task_form_store.g.dart';

class TaskFormStore = TaskFormStoreBase with _$TaskFormStore;

abstract class TaskFormStoreBase with Store {
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String? title;

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get isTitleValid => title != null && title!.isNotEmpty;

  @computed
  String? get titleError {
    // o Botão não ficara disponível quando os campos for = a null
    if (title == null || isTitleValid) {
      return null;
    } else if (title!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Título inválido';
    }
  }

  @observable
  String? description;

  @action
  void setDescription(String value) => description = value;

  @observable
  String selectedType = TaskType.PRODUCTIVITY.name;

  @action
  void setSelectedType(String value) => selectedType = value;

  @observable
  Difficulty selectedDifficulty = Difficulty.MEDIUM;

  @action
  void setSelectedDifficulty(Difficulty value) => selectedDifficulty = value;

  @observable
  TaskTheme? selectedTaskTheme;

  @action
  void setSelectedTaskTheme(TaskTheme? theme) {
    selectedTaskTheme = theme!;
    selectedSkills
        .clear(); // Limpa as habilidades selecionadas quando o tema muda
  }

  @observable
  ObservableList<String> selectedSkills = ObservableList<String>();

  @action
  void addSelectedSkill(String skillId) => selectedSkills.add(skillId);

  @action
  void removeSelectedSkill(String skillId) => selectedSkills.remove(skillId);

  @observable
  bool allDayEnabled = true;

  DateTime? oldEndDate;

  @action
  void switchAllDayEnabled(bool value) {
    allDayEnabled = value;

    if (allDayEnabled) {
      oldEndDate = endDate;
      DateTime newEndDate = endDate.subtract(Duration(
        hours: endDate.hour, // Zera as horas
        minutes: endDate.minute, // Zera os minutos
        seconds: endDate.second, // Zera os segundos
      ));
      endDate =
          newEndDate.add(const Duration(hours: 23, minutes: 59, seconds: 59));
    } else {
      // Se "dia inteiro" for desativado, restaura a hora de término original
      endDate = oldEndDate ?? endDate;
    }
  }

  @observable
  bool startDateEnabled = false;

  @action
  void setStartDateEnabled(bool value) => startDateEnabled = value;

  @observable
  DateTime startDate = DateTime.now();

  @action
  void setStartDate(DateTime value) => startDate = value;

  @observable
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  @action
  void setEndDate(DateTime value) => endDate = value;

  @observable
  bool repetitionEnabled = false;

  @action
  void setRepetitionEnabled(bool value) => repetitionEnabled = value;

  @observable
  int? selectedRepetition;

  @action
  void setSelectedRepetition(int value) => selectedRepetition = value;

  @observable
  bool reminderEnabled = false;

  @action
  void setReminderEnabled(bool value) => reminderEnabled = value;

  @observable
  int? selectedReminder;

  @action
  void setSelectedReminder(int value) => selectedReminder = value;

  @computed
  bool get isFormValid =>
      isTitleValid && selectedTaskTheme != null && selectedSkills.isNotEmpty;

  @observable
  ObservableList<String> selectedParticipants = ObservableList<String>();

  @action
  void addParticipant(String participant) {
    selectedParticipants.add(participant);
  }

  @action
  void removeParticipant(String participant) {
    selectedParticipants.remove(participant);
  }

  @action
  void clear() {
    //limpar os campos
    selectedType = TaskType.PRODUCTIVITY.name;
    loading = false;
    title = null;
    description = null;
    selectedDifficulty = Difficulty.MEDIUM;
    selectedTaskTheme = null;
    selectedSkills.clear();
    allDayEnabled = false;
    startDateEnabled = false;
    startDate = DateTime.now();
    endDate = DateTime.now().add(const Duration(days: 7));
    repetitionEnabled = false;
    selectedRepetition = null;
    reminderEnabled = false;
    selectedReminder = null;
  }
}
