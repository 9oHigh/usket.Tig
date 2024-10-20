import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/providers/tig/tig_provider.dart';

class HomeWidgetManager {
  HomeWidgetManager._privateConstructor();

  static final HomeWidgetManager _instance =
      HomeWidgetManager._privateConstructor();

  factory HomeWidgetManager() {
    return _instance;
  }

  Future<void> updateWidgetData() async {
    final container = ProviderContainer();
    final tigUsecase = container.read(tigUseCaseProvider);
    final String userId =
        FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';
    final DateTime currentDate = DateTime.now();

    final monthlyTigs = await tigUsecase.getTigsForMonth(
        userId, currentDate.year, currentDate.month);

    await _saveTigsToPreferences(monthlyTigs, currentDate);

    container.dispose();
  }

  Future<void> _saveTigsToPreferences(
      List<Tig> monthlyTigs, DateTime currentDate) async {
    final monthlyTigsJson = jsonEncode(monthlyTigs
        .map((tig) => {...tig.toMap(), 'date': tig.date.toIso8601String()})
        .toList());

    await HomeWidget.saveWidgetData<int>("current_month", currentDate.month);
    await HomeWidget.saveWidgetData<String>("monthly_tigs", monthlyTigsJson);

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

    await HomeWidget.updateWidget(
        name: 'LargeWidgetProvider', androidName: 'LargeWidgetProvider');
    await HomeWidget.updateWidget(
        name: 'SmallWidgetProvider', androidName: 'SmallWidgetProvider');
  }
}