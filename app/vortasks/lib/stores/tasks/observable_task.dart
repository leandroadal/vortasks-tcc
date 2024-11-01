import 'package:mobx/mobx.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/enums/task_theme.dart';
import 'package:vortasks/models/enums/task_type.dart';
import 'package:vortasks/models/skill/skill.dart';
import 'package:vortasks/models/tasks/task.dart';

part 'observable_task.g.dart';

class ObservableTask = ObservableTaskBase with _$ObservableTask;

abstract class ObservableTaskBase with Store {
  @observable
  Task task;

  ObservableTaskBase({required this.task});

  // Getters para acessar as propriedades da Task
  String get id => task.id;
  String get title => task.title;
  String? get icon => task.icon;
  String get description => task.description;
  Status get status => task.status;
  int get xp => task.xp;
  int get coins => task.coins;
  TaskType get type => task.type;
  int get repetition => task.repetition;
  DateTime get reminder => task.reminder;
  List<Skill> get skills => task.skills;
  int get skillIncrease => task.skillIncrease;
  int get skillDecrease => task.skillDecrease;
  DateTime get startDate => task.startDate;
  DateTime get endDate => task.endDate;
  TaskTheme get theme => task.theme;
  Difficulty get difficulty => task.difficulty;
  bool? get finish => task.finish;
  DateTime? get dateFinish => task.dateFinish;

  @action
  void setStatus(Status newStatus) {
    task = task.copyWith(status: newStatus);
  }

  @action
  void setFinish(bool? newFinish) {
    task = task.copyWith(finish: newFinish);
  }

  @action
  void setDateFinish(DateTime? newDateFinish) {
    task = task.copyWith(dateFinish: newDateFinish);
  }

  @action
  void markAsFinished() {
    task = task.copyWith(finish: true, dateFinish: DateTime.now());
  }
}
