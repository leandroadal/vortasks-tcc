class ProgressData {
  final int xp;
  final int level;
  final int coins;
  final int gems;
  final DateTime? lastModified;

  ProgressData({
    required this.xp,
    required this.level,
    required this.coins,
    required this.gems,
    this.lastModified,
  });

  factory ProgressData.fromJson(Map<String, dynamic> json) {
    return ProgressData(
      xp: json['xp'].round(),
      level: json['level'],
      coins: json['coins'],
      gems: json['gems'],
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'xp': xp,
      'level': level,
      'coins': coins,
      'gems': gems,
      'lastModified': lastModified?.toUtc().toIso8601String(),
    };
  }
}
