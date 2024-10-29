import 'package:cloud_firestore/cloud_firestore.dart';
import 'priority_entry.dart';
import 'time_entry.dart';

class Tig {
  DateTime date;
  List<PriorityEntry> dayTopPriorities;
  String brainDump;
  List<TimeEntry> timeTable;
  double startHour;
  double endHour;
  int grade;

  Tig({
    required this.date,
    List<PriorityEntry>? dayTopPriorities,
    this.brainDump = "",
    List<TimeEntry>? timeTable,
    // MARK: - 추후에는 변경가능하게 만들기
    this.startHour = 7.0,
    this.endHour = 24.0,
    this.grade = 0,
  })  : dayTopPriorities = dayTopPriorities ?? _generateDefaultPriorities(),
        timeTable = timeTable ?? _generateTimeTable(startHour, endHour);

  static List<PriorityEntry> _generateDefaultPriorities() {
    return [
      PriorityEntry(priority: '', isSucceed: false),
      PriorityEntry(priority: '', isSucceed: false),
      PriorityEntry(priority: '', isSucceed: false),
    ];
  }

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
      'dayTopPriorities':
          dayTopPriorities.map((priority) => priority.toMap()).toList(),
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
      dayTopPriorities: (map['dayTopPriorities'] as List<dynamic>?)
              ?.map((priority) => PriorityEntry.fromMap(priority))
              .toList() ??
          _generateDefaultPriorities(),
      brainDump: map['brainDump'] ?? "",
      timeTable: (map['timeTable'] as List<dynamic>?)
              ?.map((entry) => TimeEntry.fromMap(entry))
              .toList() ??
          _generateTimeTable(map['startHour']?.toDouble() ?? 7.0,
              map['endHour']?.toDouble() ?? 24.0),
      startHour: map['startHour']?.toDouble() ?? 7.0,
      endHour: map['endHour']?.toDouble() ?? 24.0,
      grade: map['grade'] ?? 0,
    );
  }
}