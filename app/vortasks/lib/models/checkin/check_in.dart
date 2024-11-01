class CheckIn {
  String id;
  int countCheckInDays;
  int month;
  int year;
  DateTime? lastCheckInDate;

  CheckIn({
    required this.id,
    required this.countCheckInDays,
    required this.month,
    required this.year,
    this.lastCheckInDate,
  });

  factory CheckIn.fromJson(Map<String, dynamic> json) {
    return CheckIn(
      id: json['id'],
      countCheckInDays: json['countCheckInDays'],
      month: json['month'],
      year: json['year'],
      lastCheckInDate: json['lastCheckInDate'] != null
          ? DateTime.parse(json['lastCheckInDate']).toLocal()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'countCheckInDays': countCheckInDays,
      'month': month,
      'year': year,
      'lastCheckInDate': lastCheckInDate?.toUtc().toIso8601String(),
    };
  }
}
