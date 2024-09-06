// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tig.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeEntryAdapter extends TypeAdapter<TimeEntry> {
  @override
  final int typeId = 0;

  @override
  TimeEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeEntry(
      activity: fields[0] as String,
      time: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TimeEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.activity)
      ..writeByte(1)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TigAdapter extends TypeAdapter<Tig> {
  @override
  final int typeId = 0;

  @override
  Tig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tig(
      date: fields[0] as DateTime,
      monthTopPriorites: (fields[1] as List).cast<String>(),
      weekTopPriorites: (fields[2] as List).cast<String>(),
      dayTopPriorites: (fields[3] as List).cast<String>(),
      brainDump: fields[4] as String,
      timeTable: (fields[5] as List).cast<TimeEntry>(),
      timeTableSuccessed: (fields[6] as List).cast<bool>(),
      startHour: fields[7] as double,
      endHour: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Tig obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.monthTopPriorites)
      ..writeByte(2)
      ..write(obj.weekTopPriorites)
      ..writeByte(3)
      ..write(obj.dayTopPriorites)
      ..writeByte(4)
      ..write(obj.brainDump)
      ..writeByte(5)
      ..write(obj.timeTable)
      ..writeByte(6)
      ..write(obj.timeTableSuccessed)
      ..writeByte(7)
      ..write(obj.startHour)
      ..writeByte(8)
      ..write(obj.endHour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
