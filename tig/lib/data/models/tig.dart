import 'package:cloud_firestore/cloud_firestore.dart';

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

class Tig {
  DateTime date;
  List<String> dayTopPriorities;
  String brainDump;
  List<TimeEntry> timeTable;
  double startHour;
  double endHour;
  int grade;

  Tig({
    required this.date,
    List<String>? monthTopPriorities,
    List<String>? weekTopPriorities,
    List<String>? dayTopPriorities,
    this.brainDump = "",
    List<TimeEntry>? timeTable,
    this.startHour = 5.0,
    this.endHour = 24.0,
    this.grade = 0,
  })  : dayTopPriorities = dayTopPriorities ?? ['', '', ''],
        timeTable = timeTable ?? _generateTimeTable(startHour, endHour);

  static List<TimeEntry> _generateTimeTable(double startHour, double endHour) {
    List<TimeEntry> timeEntries = [];
    for (double time = startHour; time <= endHour; time += 0.5) {
      timeEntries.add(TimeEntry(
        activity: '',
        time: time,
        isSucceed: false,
      ));
    }
    return timeEntries;
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'dayTopPriorities': dayTopPriorities,
      'brainDump': brainDump,
      'timeTable': timeTable.map((entry) => entry.toMap()).toList(),
      'startHour': startHour,
      'endHour': endHour,
      'grade': grade
    };
  }

  factory Tig.fromMap(Map<String, dynamic> map) {
    return Tig(
      date: (map['date'] as Timestamp).toDate(),
      dayTopPriorities:
          List<String>.from(map['dayTopPriorities'] ?? ['', '', '']),
      brainDump: map['brainDump'] ?? "",
      timeTable: (map['timeTable'] as List<dynamic>?)
              ?.map((entry) => TimeEntry.fromMap(entry))
              .toList() ??
          _generateTimeTable(map['startHour']?.toDouble() ?? 0.0,
              map['endHour']?.toDouble() ?? 24.0),
      startHour: map['startHour']?.toDouble() ?? 5.0,
      endHour: map['endHour']?.toDouble() ?? 24.0,
      grade: map['grade'] ?? 0,
    );
  }
}
