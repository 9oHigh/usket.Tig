import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/tig.dart';

// MARK: - 인앱결제 관련 상태도 필요, 추후 업데이트시 진행
class MenuState extends Equatable {
  final PageController pageController;
  final int currentSubscribePage;
  final DateTime currentDate;
  final List<Tig> monthlyTigs;
  final String userId;
  final String message;
  final bool isLoggedOutOrDelete;

  const MenuState({
    required this.pageController,
    this.currentSubscribePage = 0,
    required this.currentDate,
    this.monthlyTigs = const [],
    this.userId = "",
    this.message = "",
    this.isLoggedOutOrDelete = false,
  });

  MenuState copyWith({
    PageController? pageController,
    int? currentSubscribePage,
    List<Tig>? monthlyTigs,
    String? userId,
    String? message,
    bool? isLoggedOutOrDelete,
  }) {
    return MenuState(
      pageController: pageController ?? this.pageController,
      currentSubscribePage: currentSubscribePage ?? this.currentSubscribePage,
      currentDate: currentDate,
      monthlyTigs: monthlyTigs ?? this.monthlyTigs,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      isLoggedOutOrDelete: isLoggedOutOrDelete ?? this.isLoggedOutOrDelete,
    );
  }

  @override
  List<Object?> get props =>
      [pageController, currentSubscribePage, monthlyTigs, userId, message, isLoggedOutOrDelete];
}
