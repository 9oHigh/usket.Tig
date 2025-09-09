import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/presentation/page/option/provider/state/option_state.dart';

class OptionNotifier extends StateNotifier<OptionState> {
  OptionNotifier() : super(const OptionState()) {
    _initializeOptions();
  }

  void _initializeOptions() {
    bool isOnDaily =
        SharedPreferenceManager().getPref<bool>(PrefsType.isOnDaily) ?? false;
    bool isOnBraindump =
        SharedPreferenceManager().getPref(PrefsType.isOnBraindump) ?? false;
    TimeSystem timeSystem =
        SharedPreferenceManager().getPref(PrefsType.isTwelveTimeSystem) ??
            TimeSystem.twentyFour;
    state = state.copyWith(
        isOnDaily: isOnDaily,
        isOnBraindump: isOnBraindump,
        timeSystem: timeSystem);
  }

  Future<void> changeDailyOption(bool option) async {
    await SharedPreferenceManager().setPref<bool>(PrefsType.isOnDaily, option);
    state = state.copyWith(isOnDaily: option);
  }

  Future<void> changeBraindumpOption(bool option) async {
    await SharedPreferenceManager()
        .setPref<bool>(PrefsType.isOnBraindump, option);
    state = state.copyWith(isOnBraindump: option);
  }

  void updateTimeSystem(TimeSystem timeSystem) async {
    await SharedPreferenceManager()
        .setPref<TimeSystem>(PrefsType.isTwelveTimeSystem, timeSystem);
    state = state.copyWith(timeSystem: timeSystem);
  }
}
