import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/screens/auth/provider/state/auth_notifier.dart';
import 'package:tig/presentation/screens/auth/provider/state/auth_state.dart';

final authNotifierProvider =
    AutoDisposeStateNotifierProvider<AuthNotifier, AuthState>(
        (ref) => AuthNotifier());
