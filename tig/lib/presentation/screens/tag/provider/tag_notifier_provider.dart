import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/screens/tag/provider/state/tag_notifier.dart';
import 'package:tig/presentation/screens/tag/provider/state/tag_state.dart';

final tagNotifierProvider =
    AutoDisposeStateNotifierProvider<TagNotifier, TagState>(
        (ref) => TagNotifier());
