import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/core/di/injector.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/domain/usecases/auth_usecase.dart';
import 'package:tig/presentation/page/auth/provider/state/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase = injector.get<AuthUseCase>();

  AuthNotifier() : super(const AuthState());

  Future<void> signInWithGoogle() async {
    if (!state.isAnimationCompleted) return;

    state = state.copyWith(isLoading: true, message: "");
    try {
      await _authUseCase.signInWithGoogle();
      await SharedPreferenceManager().setPref<bool>(PrefsType.isLoggedIn, true);
      state = state.copyWith(
        message: Intl.message('auth_google_login_success'),
        isLoggedIn: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
          message:
              Intl.message('auth_google_login_failure', args: [e.toString()]),
          isLoading: false);
    }
  }

  Future<void> signInWithKakao() async {
    if (!state.isAnimationCompleted) return;

    state = state.copyWith(isLoading: true, message: "");
    try {
      await _authUseCase.signInWithKakao();
      await SharedPreferenceManager().setPref<bool>(PrefsType.isLoggedIn, true);
      state = state.copyWith(
        message: Intl.message('auth_kakao_login_success'),
        isLoggedIn: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
          message:
              Intl.message('auth_kakao_login_failure', args: [e.toString()]),
          isLoading: false);
    }
  }

  void setAnimationCompleted(bool isCompleted) {
    state = state.copyWith(isAnimationCompleted: isCompleted);
  }
}
