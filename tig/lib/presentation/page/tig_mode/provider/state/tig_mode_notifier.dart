import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tig/core/di/injector.dart';
import 'package:tig/core/manager/home_widget_manager.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/domain/usecases/tig_usecase.dart';
import 'package:tig/presentation/page/tig_mode/provider/state/tig_mode_state.dart';
import 'package:tig/utils/extentions/int_extenstion.dart';
import 'package:tig/utils/extentions/nullable_extension.dart';

class TigModeNotifier extends StateNotifier<TigModeState> {
  final TigUsecase _tigUsecase = injector.get<TigUsecase>();

  TigModeNotifier()
      : super(TigModeState(
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            audioPlayer: AudioPlayer()));

  void initialize(Tig tig) {
    state = state.copyWith(tig: tig);
    _initializeAudio();
    _initializeTimer();
  }

  Future<void> _initializeAudio() async {
    try {
      await state.audioPlayer.setAsset("assets/sounds/time_up.mp3");
    } catch (_) {
      return;
    }
  }

  void _startAudio() async {
    try {
      if (state.audioPlayer.playerState.processingState ==
          ProcessingState.completed) {
        await state.audioPlayer.seek(Duration.zero);
      }
      state.audioPlayer.play();
    } catch (_) {
      return;
    }
  }

  void stopAudio() {
    state.audioPlayer.dispose();
  }

  void _initializeTimer() {
    final int currentIndex = _getCurrentIndex();
    if (currentIndex != -1) {
      final newTimeEntry = state.tig!.timeTable[currentIndex];
      state = state.copyWith(timeEntry: newTimeEntry);
      _calculateTime();

      final remainSeconds = state.endTime.difference(DateTime.now()).inSeconds;
      state = state.copyWith(remainSeconds: remainSeconds);
      _startWaitingOrCountdown();
    }
  }

  int _getCurrentIndex() {
    final DateTime now = DateTime.now();
    final double currentTime = now.hour + (now.minute >= 30 ? 0.5 : 0);

    return state.tig?.timeTable.indexWhere((entry) {
          final entryStartTime = entry.time - 0.5;
          final entryEndTime = entry.time;
          return currentTime >= entryStartTime &&
              currentTime < entryEndTime &&
              entry.activity.isNotEmpty;
        }) ??
        -1;
  }

  void _calculateTime() {
    final entryEndTime = state.timeEntry!.time;
    final entryStartTime = entryEndTime - 0.5;
    final startTime = _createDateTime(entryStartTime);
    final endTime = _createDateTime(entryEndTime);
    state = state.copyWith(startTime: startTime, endTime: endTime);
  }

  DateTime _createDateTime(double time) {
    final now = DateTime.now();
    final hour = time.floor();
    final minute = ((time % 1) * 60).round();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  void _startWaitingOrCountdown() {
    final now = DateTime.now();
    if (now.isBefore(state.startTime)) {
      state = state.copyWith(isWaiting: true);
      _startWaitingTimer();
    } else if (now.isBefore(state.endTime)) {
      state = state.copyWith(isWaiting: false);
      _startCountdownTimer();
    } else {
      moveToNextEntry();
    }
  }

  void _startWaitingTimer() {
    state.timer?.cancel();
    final newTimer = Timer(state.startTime.difference(DateTime.now()), () {
      state = state.copyWith(isWaiting: false);
      _startCountdownTimer();
    });
    state = state.copyWith(timer: newTimer);
  }

  void _startCountdownTimer() {
    state.timer?.cancel();
    final newTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.remainSeconds > 0) {
          if (state.remainSeconds == 10) {
            _startAudio();
          }
          state = state.copyWith(remainSeconds: state.remainSeconds - 1);
        } else {
          moveToNextEntry();
        }
      },
    );
    state = state.copyWith(timer: newTimer);
  }

  void moveToNextEntry() {
    final nextIndex = _getNextEntryIndex();
    if (nextIndex != null) {
      final newTimeEntry = state.tig!.timeTable[nextIndex];
      state = state.copyWith(timeEntry: newTimeEntry);
      _calculateTime();
      state = state.copyWith(remainSeconds: 30 * 60);
      _startWaitingOrCountdown();
    } else {
      state.timer?.cancel();
      state = state.copyWith(timeEntry: null);
    }
  }

  int? _getNextEntryIndex() {
    final timeTable = state.tig?.timeTable ?? [];
    final currentIndex = timeTable.indexOf(state.timeEntry!);
    return timeTable
        .sublist(currentIndex + 1)
        .indexWhere((entry) => entry.activity.isNotEmpty)
        .takeIf((index) => index != -1)
        ?.let((relativeIndex) => currentIndex + 1 + relativeIndex);
  }

  Future<void> saveTigData() async {
    final container = ProviderContainer();
    final uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    final userId =
        SharedPreferenceManager().getPref<String>(PrefsType.userId) ?? uid;
    state.timeEntry!.isSucceed = true;
    await _tigUsecase.saveTigData(userId, state.tig!);
    await HomeWidgetManager().updateWidgetData(container);
    container.dispose();
    moveToNextEntry();
  }

  void cancelTimer() {
    state.timer?.cancel();
  }
}
