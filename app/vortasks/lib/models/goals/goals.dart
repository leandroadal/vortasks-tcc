class Goals {
  final String id;
  int dailyProductivity;
  int dailyWellBeing;
  int weeklyProductivity;
  int weeklyWellBeing;

  int dailyProductivityProgress;
  int dailyWellBeingProgress;
  int weeklyProductivityProgress;
  int weeklyWellBeingProgress;

  Goals({
    required this.id,
    required this.dailyProductivity,
    required this.dailyWellBeing,
    required this.weeklyProductivity,
    required this.weeklyWellBeing,
    required this.dailyProductivityProgress,
    required this.dailyWellBeingProgress,
    required this.weeklyProductivityProgress,
    required this.weeklyWellBeingProgress,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dailyProductivity': dailyProductivity,
      'dailyWellBeing': dailyWellBeing,
      'weeklyProductivity': weeklyProductivity,
      'weeklyWellBeing': weeklyWellBeing,
      'dailyProductivityProgress': dailyProductivityProgress,
      'dailyWellBeingProgress': dailyWellBeingProgress,
      'weeklyProductivityProgress': weeklyProductivityProgress,
      'weeklyWellBeingProgress': weeklyWellBeingProgress,
    };
  }

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      id: json['id'],
      dailyProductivity: json['dailyProductivity'],
      dailyWellBeing: json['dailyWellBeing'],
      weeklyProductivity: json['weeklyProductivity'],
      weeklyWellBeing: json['weeklyWellBeing'],
      dailyProductivityProgress: json['dailyProductivityProgress'],
      dailyWellBeingProgress: json['dailyWellBeingProgress'],
      weeklyProductivityProgress: json['weeklyProductivityProgress'],
      weeklyWellBeingProgress: json['weeklyWellBeingProgress'],
    );
  }

  Goals copyWith({
    String? id,
    int? dailyProductivity,
    int? dailyWellBeing,
    int? weeklyProductivity,
    int? weeklyWellBeing,
    int? dailyProductivityProgress,
    int? dailyWellBeingProgress,
    int? weeklyProductivityProgress,
    int? weeklyWellBeingProgress,
  }) {
    return Goals(
      id: id ?? this.id,
      dailyProductivity: dailyProductivity ?? this.dailyProductivity,
      dailyWellBeing: dailyWellBeing ?? this.dailyWellBeing,
      weeklyProductivity: weeklyProductivity ?? this.weeklyProductivity,
      weeklyWellBeing: weeklyWellBeing ?? this.weeklyWellBeing,
      dailyProductivityProgress:
          dailyProductivityProgress ?? this.dailyProductivityProgress,
      dailyWellBeingProgress:
          dailyWellBeingProgress ?? this.dailyWellBeingProgress,
      weeklyProductivityProgress:
          weeklyProductivityProgress ?? this.weeklyProductivityProgress,
      weeklyWellBeingProgress:
          weeklyWellBeingProgress ?? this.weeklyWellBeingProgress,
    );
  }
}
