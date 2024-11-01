import 'package:vortasks/models/social/friendship_data.dart';

class Friendship {
  final String id;
  final List<FriendshipData> users;
  final DateTime friendshipDate;

  Friendship({
    required this.id,
    required this.users,
    required this.friendshipDate,
  });

  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      id: json['id'],
      users: (json['users'] as List<dynamic>)
          .map((userJson) => FriendshipData.fromJson(userJson))
          .toList(),
      friendshipDate: DateTime.parse(json['friendshipDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users': users.map((user) => user.toJson()).toList(),
      'friendshipDate': friendshipDate.toIso8601String(),
    };
  }
}
