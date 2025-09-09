import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/page/home/provider/state/home_notifier.dart';
import 'package:tig/presentation/page/home/provider/state/home_state.dart';

final homeNotifierProvider =
    AutoDisposeStateNotifierProvider<HomeNotifier, HomeState>(
        (ref) => HomeNotifier());