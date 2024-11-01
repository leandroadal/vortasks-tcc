import 'package:intl/intl.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/models/enums/status.dart';
import 'package:vortasks/models/enums/task_theme.dart';
import 'package:vortasks/models/enums/task_type.dart';

class GroupSubtask {
  final String id;
  String title;
  final String? description;
  Status status;
  final int xp;
  final int coins;
  final TaskType type;
  final int repetition;
  final DateTime reminder;
  final int skillIncrease;
  final int skillDecrease;
  final DateTime startDate;
  final DateTime endDate;
  final TaskTheme theme;
  final Difficulty difficulty;
  bool? finish;
  DateTime? dateFinish;
  final Set<String> skills;
  final List<String> participants; // Lista de usuários participantes

  GroupSubtask({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.xp,
    required this.coins,
    required this.type,
    required this.repetition,
    required this.reminder,
    required this.skillIncrease,
    required this.skillDecrease,
    required this.startDate,
    required this.endDate,
    required this.theme,
    required this.difficulty,
    this.finish,
    this.dateFinish,
    required this.skills,
    required this.participants,
  });

  factory GroupSubtask.fromJson(Map<String, dynamic> json) {
    return GroupSubtask(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: _getStatusFromString(json['status']),
      xp: json['xp'],
      coins: json['coins'],
      type: _getTypeFromString(json['type']),
      repetition: json['repetition'],
      reminder: DateTime.parse(json['reminder']),
      skillIncrease: json['skillIncrease'],
      skillDecrease: json['skillDecrease'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      theme: _getThemeFromString(json['theme']),
      difficulty: _getDifficultyFromString(json['difficulty']),
      finish: json['finish'],
      dateFinish: json['dateFinish'] != null
          ? DateTime.tryParse(json['dateFinish'])
          : null,
      skills: (json['skills'] as List<dynamic>).cast<String>().toSet(),
      participants: (json['participants'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.toString().split('.').last,
      'xp': xp,
      'coins': coins,
      'type': type.toString().split('.').last,
      'repetition': repetition,
      'reminder': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(reminder),
      'skillIncrease': skillIncrease,
      'skillDecrease': skillDecrease,
      'startDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(startDate),
      'endDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(endDate),
      'theme': theme.toString().split('.').last,
      'difficulty': difficulty.toString().split('.').last,
      'finish': finish ?? false,
      'dateFinish': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
          .format(dateFinish ?? DateTime.utc(1)),
      'skills': skills.toList(),
      'participants': participants,
    };
  }

  static Status _getStatusFromString(String status) {
    return Status.values.firstWhere(
      (element) => element.toString().split('.').last == status,
      orElse: () => Status.IN_PROGRESS,
    );
  }

  static TaskType _getTypeFromString(String type) {
    return TaskType.values.firstWhere(
      (element) => element.toString().split('.').last == type,
      orElse: () => TaskType.WELL_BEING,
    );
  }

  static TaskTheme _getThemeFromString(String theme) {
    return TaskTheme.values.firstWhere(
      (element) => element.toString().split('.').last == theme,
      orElse: () => TaskTheme.WELLNESS,
    );
  }

  static Difficulty _getDifficultyFromString(String difficulty) {
    return Difficulty.values.firstWhere(
      (element) => element.toString().split('.').last == difficulty,
      orElse: () => Difficulty.EASY,
    );
  }
}
