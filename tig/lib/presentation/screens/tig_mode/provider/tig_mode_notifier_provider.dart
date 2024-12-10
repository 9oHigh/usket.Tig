import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/screens/tig_mode/provider/state/tig_mode_notifier.dart';
import 'package:tig/presentation/screens/tig_mode/provider/state/tig_mode_state.dart';

final tigModeNotifierProvider =
    AutoDisposeStateNotifierProvider<TigModeNotifier, TigModeState>((ref) {
  final TigModeNotifier tigModeNotifier = TigModeNotifier();
  ref.onDispose(() {
    tigModeNotifier.cancelTimer();
    tigModeNotifier.stopAudio();
  });
  return tigModeNotifier;
});
