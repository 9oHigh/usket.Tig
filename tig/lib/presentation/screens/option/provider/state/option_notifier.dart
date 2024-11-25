import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/presentation/screens/option/provider/state/option_state.dart';

class OptionNotifier extends StateNotifier<OptionState> {
  OptionNotifier() : super(const OptionState()) {
    _initailizeOptions();
  }

  void _initailizeOptions() {
    bool isOnDaily =
        SharedPreferenceManager().getPref<bool>(PrefsType.isOnDaily) ?? false;
    bool isOnBraindump =
        SharedPreferenceManager().getPref(PrefsType.isOnBraindump) ?? false;
    state = state.copyWith(isOnDaily: isOnDaily, isOnBraindump: isOnBraindump);
  }

  Future<void> changeDailyOption(bool option) async {
    await SharedPreferenceManager().setPref<bool>(PrefsType.isOnDaily, option);
    state = state.copyWith(isOnDaily: option);
  }

  Future<void> changeBraindumpOption(bool option) async {
    await SharedPreferenceManager().setPref<bool>(PrefsType.isOnBraindump, option);
    state = state.copyWith(isOnBraindump: option);
  }
}
