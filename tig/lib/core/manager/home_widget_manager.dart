import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:tig/core/di/injector.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/domain/usecases/tig_usecase.dart';

class HomeWidgetManager {
  HomeWidgetManager._privateConstructor();

  static final HomeWidgetManager _instance =
      HomeWidgetManager._privateConstructor();

  factory HomeWidgetManager() => _instance;

  Future<void> updateWidgetData(ProviderContainer container) async {
    final tigUsecase = injector.get<TigUsecase>();
    final userId = _getUserId();
    final currentDate = DateTime.now();

    final monthlyTigs = await tigUsecase.getTigsForMonth(
        userId, currentDate.year, currentDate.month);

    await _saveMonthlyData(monthlyTigs, currentDate);
    await _saveTodayData(monthlyTigs, currentDate);
    await _updateWidgets();
  }

  String _getUserId() =>
      FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';

  Future<void> _saveMonthlyData(
      List<Tig> monthlyTigs, DateTime currentDate) async {
    final monthlyTigsJson = jsonEncode(
      monthlyTigs
          .map((tig) => {...tig.toMap(), 'date': tig.date.toIso8601String()})
          .toList(),
    );
    await HomeWidget.saveWidgetData<int>("current_month", currentDate.month);
    await HomeWidget.saveWidgetData<String>("monthly_tigs", monthlyTigsJson);
  }

  Future<void> _saveTodayData(
      List<Tig> monthlyTigs, DateTime currentDate) async {
    final todayTig = monthlyTigs.firstWhere(
      (tig) =>
          tig.date.year == currentDate.year &&
          tig.date.month == currentDate.month &&
          tig.date.day == currentDate.day,
      orElse: () => Tig(date: currentDate, timeTable: []),
    );

    final todayTigJson = jsonEncode(
      {...todayTig.toMap(), 'date': todayTig.date.toIso8601String()},
    );

    await HomeWidget.saveWidgetData<int>("current_day", currentDate.day);
    await HomeWidget.saveWidgetData<String>("today_tig", todayTigJson);
  }

  Future<void> _updateWidgets() async {
    await HomeWidget.updateWidget(
        name: 'LargeWidgetProvider', androidName: 'LargeWidgetProvider');
    await HomeWidget.updateWidget(
        name: 'SmallWidgetProvider', androidName: 'SmallWidgetProvider');
  }
}
