class FriendshipData {
  final String id;
  final String name;
  final int level;
  final String username;

  FriendshipData({
    required this.id,
    required this.name,
    required this.level,
    required this.username,
  });

  factory FriendshipData.fromJson(Map<String, dynamic> json) {
    return FriendshipData(
      id: json['id'],
      name: json['name'],
      level: json['level'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'username': username,
    };
  }
}
