import 'package:intl/intl.dart';
import 'package:vortasks/models/social/group_subtask.dart';

class GroupTask {
  final String id;
  final String title;
  final String? description;
  final String author;
  final List<String> editors;
  final List<String> participants;
  final DateTime createdAt;
  final List<GroupSubtask> groupSubtask;
  final DateTime startDate;
  final DateTime endDate;
  bool finish;
  DateTime? dateFinish;

  GroupTask({
    required this.id,
    required this.title,
    this.description,
    required this.author,
    required this.editors,
    required this.participants,
    required this.createdAt,
    required this.groupSubtask,
    required this.startDate,
    required this.endDate,
    required this.finish,
    this.dateFinish,
  });

  factory GroupTask.fromJson(Map<String, dynamic> json) {
    return GroupTask(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      editors: List<String>.from(json['editors']),
      participants: List<String>.from(json['participants']),
      createdAt: DateTime.parse(json['createdAt']),
      groupSubtask: (json['groupSubtasks'] as List<dynamic>?)
              ?.map((taskJson) => GroupSubtask.fromJson(taskJson))
              .toList() ??
          [],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      finish: json['finish'],
      dateFinish: json['dateFinish'] != null
          ? DateTime.tryParse(json['dateFinish'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author,
      'editors': editors,
      'participants': participants,
      'createdAt': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(createdAt),
      'groupSubtasks': groupSubtask.map((task) => task.toJson()).toList(),
      'startDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(startDate),
      'endDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(endDate),
      'finish': finish,
      'dateFinish': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
          .format(dateFinish ?? DateTime.utc(1)),
    };
  }
}
