import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/page/menu/provider/state/menu_notifier.dart';
import 'package:tig/presentation/page/menu/provider/state/menu_state.dart';

final menuNotifierProvider =
    AutoDisposeStateNotifierProvider<MenuNotifier, MenuState>(
        (ref) => MenuNotifier());
