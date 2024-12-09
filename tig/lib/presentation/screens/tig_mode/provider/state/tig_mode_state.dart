import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/data/models/time_entry.dart';

class TigModeState extends Equatable {
  final Tig? tig;
  final TimeEntry? timeEntry;
  final Timer? timer;
  final DateTime startTime;
  final DateTime endTime;

  final bool isWaiting;
  final int remainSeconds;

  final AudioPlayer audioPlayer;

  const TigModeState({
    this.tig,
    this.timeEntry,
    this.timer,
    required this.startTime,
    required this.endTime,
    this.isWaiting = false,
    this.remainSeconds = 100,
    required this.audioPlayer,
  });

  TigModeState copyWith({
    Tig? tig,
    TimeEntry? timeEntry,
    Timer? timer,
    DateTime? startTime,
    DateTime? endTime,
    bool? isWaiting,
    int? remainSeconds,
    AudioPlayer? audioPlayer,
  }) {
    return TigModeState(
      tig: tig ?? this.tig,
      timeEntry: timeEntry ?? this.timeEntry,
      timer: timer ?? this.timer,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isWaiting: isWaiting ?? this.isWaiting,
      remainSeconds: remainSeconds ?? this.remainSeconds,
      audioPlayer: audioPlayer ?? this.audioPlayer,
    );
  }

  @override
  List<Object?> get props => [
        tig,
        timeEntry,
        timer,
        startTime,
        endTime,
        isWaiting,
        remainSeconds,
        audioPlayer,
      ];
}
