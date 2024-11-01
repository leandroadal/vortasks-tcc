class Achievement {
  final String id;
  final String title;
  final String description;
  final int coins;
  final int gems;
  bool unlocked;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.coins,
    required this.gems,
    this.unlocked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coins': coins,
      'gems': gems,
      'unlocked': unlocked,
    };
  }

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coins: json['coins'],
      gems: json['gems'],
      unlocked: json['unlocked'],
    );
  }
}
