class TimeEntry {
  String activity;
  double time;
  bool isSucceed;

  TimeEntry({
    required this.activity,
    required this.time,
    required this.isSucceed,
  });

  Map<String, dynamic> toMap() {
    return {
      'activity': activity,
      'time': time,
      'isSucceed': isSucceed,
    };
  }

  factory TimeEntry.fromMap(Map<String, dynamic> map) {
    return TimeEntry(
      activity: map['activity'] ?? '',
      time: map['time']?.toDouble() ?? 0.0,
      isSucceed: map['isSucceed'] ?? false,
    );
  }
}