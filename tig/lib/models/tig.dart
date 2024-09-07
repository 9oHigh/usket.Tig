import 'package:hive/hive.dart';
part 'tig.g.dart';

const int tigHiveTypeId = 0;
const int timeEntryHiveTypeId = 0;

@HiveType(typeId: timeEntryHiveTypeId)
class TimeEntry {
  @HiveField(0)
  String activity;

  @HiveField(1)
  double time;

  TimeEntry({
    required this.activity,
    required this.time,
  });
}

@HiveType(typeId: tigHiveTypeId)
class Tig {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List<String> monthTopPriorites;

  @HiveField(2)
  List<String> weekTopPriorites;

  @HiveField(3)
  List<String> dayTopPriorites;

  @HiveField(4)
  String? brainDump;

  @HiveField(5)
  List<TimeEntry> timeTable;

  @HiveField(6)
  List<bool> timeTableSuccessed;

  @HiveField(7)
  double startHour;

  @HiveField(8)
  double endHour;

  Tig({
    required this.date,
    this.monthTopPriorites = const [],
    this.weekTopPriorites = const [],
    this.dayTopPriorites = const [],
    this.brainDump,
    this.timeTable = const [],
    this.timeTableSuccessed = const [],
    this.startHour = 7.0, // sharedpreferences 로 기본값 수정
    this.endHour = 23.0, // sharedpreferences 로 기본값 수정
  });
}
