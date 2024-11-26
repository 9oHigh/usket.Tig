import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/core/di/injector.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/domain/usecases/auth_usecase.dart';
import 'package:tig/domain/usecases/tig_usecase.dart';
import 'package:tig/presentation/screens/menu/provider/state/menu_state.dart';

class MenuNotifier extends StateNotifier<MenuState> {
  final TigUsecase _tigUsecase = injector.get<TigUsecase>();
  final AuthUseCase _authUseCase = injector.get<AuthUseCase>();

  MenuNotifier()
      : super(MenuState(
          pageController: PageController(),
          currentDate: DateTime.now(),
        )) {
    _initailize();
  }

  Future<void> _initailize() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? "";
    state = state.copyWith(userId: userId);
    await _fetchMonthlyTigs();
  }

  Future<void> _fetchMonthlyTigs() async {
    final DateTime current = DateTime.now();
    final monthlyTigs = await _tigUsecase.getTigsForMonth(
        state.userId, current.year, current.month);
    state = state.copyWith(monthlyTigs: monthlyTigs);
  }

  Future<void> sendEmail() async {
    final Email email = Email(
      subject: Intl.message('menu_email_subject'),
      body: Intl.message('menu_email_body'),
      recipients: ['usket@icloud.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  Future<void> logout() async {
    await SharedPreferenceManager().setPref<bool>(PrefsType.isLoggedIn, false);
    state = state.copyWith(message: "", isLoggedOutOrDelete: true);
  }

  Future<void> deleteUser() async {
    try {
      await _authUseCase.deleteUser();
      await SharedPreferenceManager()
          .setPref<bool>(PrefsType.isLoggedIn, false);
      state = state.copyWith(message: "", isLoggedOutOrDelete: true);
    } catch (_) {
      state = state.copyWith(message: Intl.message('menu_delete_user_failure'));
    }
  }

  void updateSubscribePage(int page) {
    state = state.copyWith(currentSubscribePage: page);
  }
}
