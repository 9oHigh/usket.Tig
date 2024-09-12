class TimeEntry {
  String activity;
  double time;

  TimeEntry({
    required this.activity,
    required this.time,
  });

  // Firestore에 저장하기 위한 Map 변환 메서드
  Map<String, dynamic> toMap() {
    return {
      'activity': activity,
      'time': time,
    };
  }

  // Firestore에서 가져온 데이터를 TimeEntry 객체로 변환하는 메서드
  factory TimeEntry.fromMap(Map<String, dynamic> map) {
    return TimeEntry(
      activity: map['activity'] ?? '',
      time: map['time']?.toDouble() ?? 0.0,
    );
  }
}

class Tig {
  DateTime date;
  List<String> monthTopPriorites;
  List<String> weekTopPriorites;
  List<String> dayTopPriorites;
  String? brainDump;
  List<TimeEntry> timeTable;
  List<bool> timeTableSuccessed;
  double startHour;
  double endHour;

  Tig({
    required this.date,
    this.monthTopPriorites = const [],
    this.weekTopPriorites = const [],
    this.dayTopPriorites = const [],
    this.brainDump,
    this.timeTable = const [],
    this.timeTableSuccessed = const [],
    this.startHour = 7.0,
    this.endHour = 23.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'monthTopPriorites': monthTopPriorites,
      'weekTopPriorites': weekTopPriorites,
      'dayTopPriorites': dayTopPriorites,
      'brainDump': brainDump,
      'timeTable': timeTable.map((entry) => entry.toMap()).toList(),
      'timeTableSuccessed': timeTableSuccessed,
      'startHour': startHour,
      'endHour': endHour,
    };
  }

  factory Tig.fromMap(Map<String, dynamic> map) {
    return Tig(
      date: DateTime.parse(map['date']),
      monthTopPriorites: List<String>.from(map['monthTopPriorites'] ?? []),
      weekTopPriorites: List<String>.from(map['weekTopPriorites'] ?? []),
      dayTopPriorites: List<String>.from(map['dayTopPriorites'] ?? []),
      brainDump: map['brainDump'],
      timeTable: (map['timeTable'] as List<dynamic>?)
              ?.map((entry) => TimeEntry.fromMap(entry))
              .toList() ??
          [],
      timeTableSuccessed: List<bool>.from(map['timeTableSuccessed'] ?? []),
      startHour: map['startHour']?.toDouble() ?? 7.0,
      endHour: map['endHour']?.toDouble() ?? 23.0,
    );
  }
}
