import 'package:intl/intl.dart';
import 'package:vortasks/models/achievement/achievement.dart';
import 'package:vortasks/models/checkin/check_in.dart';
import 'package:vortasks/models/goals/goal_history.dart';
import 'package:vortasks/models/goals/goals.dart';
import 'package:vortasks/models/skill/skill.dart';
import 'package:vortasks/models/tasks/task.dart';

class Backup {
  final String id;
  final DateTime lastModified;
  final List<CheckIn> checkIns;
  final Goals goals;
  final List<Achievement> achievements;
  final List<Task> tasks;
  final List<Skill> skills;
  final List<GoalHistory> goalHistory;

  Backup(
      {required this.id,
      required this.lastModified,
      required this.checkIns,
      required this.goals,
      required this.achievements,
      required this.tasks,
      required this.skills,
      required this.goalHistory});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastModified':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(lastModified),
      'goals': goals.toJson(),
      'achievements':
          achievements.map((achievement) => achievement.toJson()).toList(),
      'tasks': tasks.map((task) => task.toJson()).toList(),
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'checkIns': checkIns.map((checkIn) => checkIn.toJson()).toList(),
      'goalHistory': goalHistory.map((progress) => progress.toJson()).toList(),
    };
  }

  factory Backup.fromJson(Map<String, dynamic> json) {
    return Backup(
      id: json['id'],
      lastModified: DateTime.parse(json['lastModified']).toLocal(),
      goals: Goals.fromJson(json['goals']),
      achievements: (json['achievements'] as List<dynamic>)
          .map((achievementJson) => Achievement.fromJson(achievementJson))
          .toList(),
      tasks: (json['tasks'] as List<dynamic>)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList(),
      skills: (json['skills'] as List<dynamic>)
          .map((skillJson) => Skill.fromJson(skillJson))
          .toList(),
      checkIns: (json['checkIns'] as List<dynamic>)
          .map((checkInJson) => CheckIn.fromJson(checkInJson))
          .toList(),
      goalHistory: (json['goalHistory'] as List<dynamic>)
          .map((progressJson) => GoalHistory.fromJson(progressJson))
          .toList(),
    );
  }
}
