import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/screens/menu/provider/menu_notifier_provider.dart';
import 'package:tig/presentation/screens/menu/provider/state/menu_notifier.dart';
import 'package:tig/presentation/screens/menu/provider/state/menu_state.dart';
import '../../../core/routes/app_route.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }

  String _getCurrentLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  String _getMonthName(int month, String language) {
    switch (language) {
      case 'ko':
        return '$month월 Tigs';
      case 'ja':
        return '$month月のTigs';
      case 'en':
        return '${[
          '',
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December'
        ][month]} Tigs';
      case 'es':
        return '${[
          '',
          'Enero',
          'Febrero',
          'Marzo',
          'Abril',
          'Mayo',
          'Junio',
          'Julio',
          'Agosto',
          'Septiembre',
          'Octubre',
          'Noviembre',
          'Diciembre'
        ][month]} Tigs';
      case 'pt':
        return '${[
          '',
          'Janeiro',
          'Fevereiro',
          'Março',
          'Abril',
          'Maio',
          'Junho',
          'Julho',
          'Agosto',
          'Setembro',
          'Outubro',
          'Novembro',
          'Dezembro'
        ][month]} Tigs';
      case 'de':
        return '${[
          '',
          'Januar',
          'Februar',
          'März',
          'April',
          'Mai',
          'Juni',
          'Juli',
          'August',
          'September',
          'Oktober',
          'November',
          'Dezember'
        ][month]} Tigs';
      case 'zh':
        return '${[
          '',
          '一',
          '二',
          '三',
          '四',
          '五',
          '六',
          '七',
          '八',
          '九',
          '十',
          '十一',
          '十二'
        ][month]}月 Tigs';
      default:
        return "$month's Tigs";
    }
  }

  void _showDialog(
      {required String title,
      required String content,
      required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Text(content, textAlign: TextAlign.center),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(Intl.message('cancel')),
              ),
              TextButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                child: Text(Intl.message('ok')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColorForGrade(int grade) {
    switch (grade) {
      case 0:
        return const Color.fromARGB(255, 231, 231, 231);
      case 1:
        return Colors.green[300]!;
      case 2:
        return Colors.green[500]!;
      case 3:
        return Colors.green[700]!;
      case 4:
        return Colors.green[900]!;
      default:
        return const Color.fromARGB(255, 231, 231, 231);
    }
  }

  void _goToAuthScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.auth,
      (Route<dynamic> route) => false,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuState = ref.watch(menuNotifierProvider);
    final menuNotifier = ref.read(menuNotifierProvider.notifier);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Future.microtask(() {
      if (menuState.message.isNotEmpty) _showSnackBar(menuState.message);
      if (menuState.isLoggedOutOrDelete) _goToAuthScreen();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Intl.message('setting'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildMonthlyTigsSection(menuState),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IgnorePointer(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildSubscriptionSection(menuState, menuNotifier),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        Intl.message('menu_update_intro'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildActionButtons(menuNotifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthlyTigsSection(MenuState menuState) {
    final DateTime currentDate = menuState.currentDate;
    final List<Tig> monthlyTigs = menuState.monthlyTigs;
    final nextMonth = DateTime(currentDate.year, currentDate.month + 1, 1);
    final lastDay = nextMonth.subtract(const Duration(days: 1)).day;
    final langCode = _getCurrentLanguageCode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getMonthName(currentDate.month, langCode),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: lastDay,
            itemBuilder: (context, index) {
              final tigForDay = monthlyTigs.firstWhere(
                (tig) => tig.date.day == index + 1,
                orElse: () => Tig(
                    date: DateTime(
                        currentDate.year, currentDate.month, index + 1),
                    timeTable: []),
              );
              return _buildDayTile(tigForDay, index + 1);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDayTile(Tig tig, int day) {
    return Container(
      decoration: BoxDecoration(
        color: _getColorForGrade(tig.grade),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: tig.grade > 0 ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildSubscriptionSection(MenuState menuState, MenuNotifier menuNotifier) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text(Intl.message('menu_subscribe')),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(Intl.message('menu_price_per_month', args: ["490₩"])),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: PageView(
            controller: menuState.pageController,
            onPageChanged: (value) => menuNotifier.updateSubscribePage(value),
            children: [
              Center(
                child: Text(
                  Intl.message('menu_subscribe_get1'),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  Intl.message('menu_subscribe_get2'),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  Intl.message('menu_subscribe_get3'),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        /*
        인앱결제 출시 때, 적용하기.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => _buildPageIndicator(index)),
        ),
        */
      ],
    );
  }

  /*
  인앱결제 출시 때, 적용하기.
  Widget _buildPageIndicator(int index) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: _currentSubscribePage == index ? 12 : 8,
      height: _currentSubscribePage == index ? 12 : 8,
      decoration: BoxDecoration(
        color: _currentSubscribePage == index
            ? (isDarkMode ? Colors.white : Colors.black)
            : (isDarkMode ? Colors.grey.shade700 : Colors.grey),
        shape: BoxShape.circle,
      ),
    );
  }
  */

  Widget _buildActionButtons(MenuNotifier menuNotifier) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () => menuNotifier.sendEmail(),
            child: Text(Intl.message('menu_contact_us')),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _showDialog(
              title: Intl.message('menu_withdrawal_title'),
              content: Intl.message('menu_withdrawal_content'),
              onConfirm: menuNotifier.deleteUser,
            ),
            child: Text(Intl.message('menu_withdrawal_text')),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _showDialog(
              title: Intl.message('menu_logout_title'),
              content: Intl.message('menu_logout_content'),
              onConfirm: menuNotifier.logout,
            ),
            child: Text(Intl.message('menu_logout_text')),
          ),
        ],
      ),
    );
  }
}
