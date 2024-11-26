import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/screens/option/provider/state/option_notifier.dart';
import 'package:tig/presentation/screens/option/provider/state/option_state.dart';

final optionNotifierProvider =
    AutoDisposeStateNotifierProvider<OptionNotifier, OptionState>(
        (ref) => OptionNotifier());
