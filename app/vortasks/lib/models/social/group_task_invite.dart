class GroupTaskInvite {
  final String id;
  final String groupTaskId;
  final String userId;
  final String status; // "PENDING", "ACCEPTED", "REJECTED"
  final DateTime createdAt;

  GroupTaskInvite({
    required this.id,
    required this.groupTaskId,
    required this.userId,
    required this.status,
    required this.createdAt,
  });

  factory GroupTaskInvite.fromJson(Map<String, dynamic> json) {
    return GroupTaskInvite(
      id: json['id'],
      groupTaskId: json['groupTaskId'],
      userId: json['userId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
