import 'package:intl/intl.dart';
import 'package:vortasks/models/enums/goal_type.dart';
import 'package:vortasks/models/enums/task_type.dart';

class GoalHistory {
  final String id;
  final DateTime date;
  final int weekNumber;
  final TaskType type;
  final GoalType goalType;
  int successes;
  int failures;

  GoalHistory({
    required this.id,
    required this.date,
    required this.weekNumber,
    required this.type,
    required this.goalType,
    required this.successes,
    required this.failures,
  });

  factory GoalHistory.fromJson(Map<String, dynamic> json) {
    return GoalHistory(
      id: json['id'],
      date: DateTime.parse(json['date']),
      weekNumber: json['weekNumber'],
      type: TaskType.values.byName(json['type']),
      goalType: GoalType.values.byName(json['goalType']),
      successes: json['successes'],
      failures: json['failures'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(date),
      'weekNumber': weekNumber,
      'type': type.name,
      'goalType': goalType.name,
      'successes': successes,
      'failures': failures,
    };
  }
}
