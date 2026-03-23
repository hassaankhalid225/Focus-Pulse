class StreakData {
  final int currentStreak;
  final int totalSprintsAllTime;
  final DateTime? lastSprintDate;

  StreakData({
    required this.currentStreak,
    required this.totalSprintsAllTime,
    this.lastSprintDate,
  });

  factory StreakData.initial() => StreakData(
        currentStreak: 0,
        totalSprintsAllTime: 0,
        lastSprintDate: null,
      );

  factory StreakData.fromJson(Map<String, dynamic> json) => StreakData(
        currentStreak: json['currentStreak'] ?? 0,
        totalSprintsAllTime: json['totalSprintsAllTime'] ?? 0,
        lastSprintDate: json['lastSprintDate'] != null
            ? DateTime.parse(json['lastSprintDate'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'currentStreak': currentStreak,
        'totalSprintsAllTime': totalSprintsAllTime,
        'lastSprintDate': lastSprintDate?.toIso8601String(),
      };

  StreakData copyWith({
    int? currentStreak,
    int? totalSprintsAllTime,
    DateTime? lastSprintDate,
  }) {
    return StreakData(
      currentStreak: currentStreak ?? this.currentStreak,
      totalSprintsAllTime: totalSprintsAllTime ?? this.totalSprintsAllTime,
      lastSprintDate: lastSprintDate ?? this.lastSprintDate,
    );
  }
}
