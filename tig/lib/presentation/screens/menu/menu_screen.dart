import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/providers/auth/auth_provider.dart';
import 'package:tig/presentation/providers/tig/tig_provider.dart';
import '../../../core/routes/app_route.dart';

class _SubscriptionPageContent extends StatelessWidget {
  final String text;

  const _SubscriptionPageContent({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 244, 242, 236),
      child: Center(child: Text(text, textAlign: TextAlign.center)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _ActionButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  int _currentSubscribePage = 0;
  final PageController _pageController = PageController();
  late DateTime _currentDate;
  late String _userId;
  List<Tig> _monthlyTigs = [];

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _userId = FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';
    _fetchMonthlyTigs();
  }

  Future<void> _fetchMonthlyTigs() async {
    final tigUsecase = ref.read(tigUseCaseProvider);
    final monthlyTigs = await tigUsecase.getTigsForMonth(
        _userId, _currentDate.year, _currentDate.month);

    await _saveMonthlyTigsToPreferences(monthlyTigs);
    await _saveTodayTigsToPreferences(monthlyTigs);

    setState(() {
      _monthlyTigs = monthlyTigs;
    });
  }

  Future<void> _saveMonthlyTigsToPreferences(List<Tig> monthlyTigs) async {
    final monthlyTigsJson = jsonEncode(monthlyTigs
        .map((tig) => {...tig.toMap(), 'date': tig.date.toIso8601String()})
        .toList());

    await HomeWidget.saveWidgetData<int>("current_month", _currentDate.month);
    await HomeWidget.saveWidgetData<String>("monthly_tigs", monthlyTigsJson);
    await HomeWidget.updateWidget(
        name: 'LargeWidgetProvider', androidName: 'LargeWidgetProvider');
  }

  Future<void> _saveTodayTigsToPreferences(List<Tig> monthlyTigs) async {
    final today = DateTime.now();
    final todayTig = monthlyTigs.firstWhere(
      (tig) =>
          tig.date.year == today.year &&
          tig.date.month == today.month &&
          tig.date.day == today.day,
      orElse: () => Tig(date: today, timeTable: []),
    );

    final todayTigJson = todayTig != null
        ? jsonEncode(
            {...todayTig.toMap(), 'date': todayTig.date.toIso8601String()})
        : null;

    await HomeWidget.saveWidgetData<int>("current_day", _currentDate.day);
    await HomeWidget.saveWidgetData<String>("today_tig", todayTigJson);
    await HomeWidget.updateWidget(
        name: 'SmallWidgetProvider', androidName: 'SmallWidgetProvider');
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

  Future<void> _sendEmail() async {
    final Email email = Email(
      subject: "문의드립니다.",
      body: """
아래의 내용을 함께 보내주시면 큰 도움이 됩니다😊
사용 중인 스마트폰: 
오류 혹은 개선점: 


이 외에 문의할 것이 있다면 편하게 작성해주세요 :)
      """,
      recipients: ['usket@icloud.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
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
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _deleteUser() async {
    try {
      final authUsecase = ref.read(authUseCaseProvider);
      await authUsecase.deleteUser();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", false);
      _goToAuthScreen();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting user: $e')),
      );
    }
  }

  Future<void> _logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);
    _goToAuthScreen();
  }

  void _goToAuthScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.auth,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
              _buildMonthlyTigsSection(),
              const SizedBox(height: 12),
              _buildSubscriptionSection(),
              const SizedBox(height: 12),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthlyTigsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_currentDate.month}월 Tigs',
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
            itemCount:
                DateTime(_currentDate.year, _currentDate.month + 1, 0).day,
            itemBuilder: (context, index) => _buildDayTile(index + 1),
          ),
        ),
      ],
    );
  }

  Widget _buildDayTile(int day) {
    final tigForDay = _monthlyTigs.firstWhere(
      (tig) => tig.date.day == day,
      orElse: () => Tig(
          date: DateTime(_currentDate.year, _currentDate.month, day),
          timeTable: []),
    );
    return Container(
      decoration: BoxDecoration(
        color: _getColorForGrade(tigForDay.grade),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
              color: tigForDay.grade > 0 ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildSubscriptionSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('구독하기',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: Text('490₩/월'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: PageView(
            controller: _pageController,
            onPageChanged: (value) =>
                setState(() => _currentSubscribePage = value),
            children: const [
              _SubscriptionPageContent(
                  text: '구독하면 이런게 생겨요!\n화면에 표시되는 모든 광고가 제거됩니다😊'),
              _SubscriptionPageContent(
                  text: '구독하면 이런게 생겨요!\n얼마나 열심히 진행하는지 한 눈에 볼 수 있게 위젯을 제공해요😊'),
              _SubscriptionPageContent(
                  text:
                      '구독하면 이런게 생겨요!\n개발자가 더 나은 앱을 만들어갈 수 있는\n 원동력을 주실 수 있어요😊\n반드시 보답할게요!'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => _buildPageIndicator(index)),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: _currentSubscribePage == index ? 12 : 8,
      height: _currentSubscribePage == index ? 12 : 8,
      decoration: BoxDecoration(
        color: _currentSubscribePage == index ? Colors.black : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ActionButton(text: '문의 하기', onPressed: _sendEmail),
          const SizedBox(height: 8),
          _ActionButton(
            text: '회원탈퇴',
            onPressed: () => _showDialog(
              title: '회원탈퇴 안내',
              content: '회원 탈퇴시 모든 정보가 제거됩니다.\n그래도 진행하시겠습니까?',
              onConfirm: _deleteUser,
            ),
          ),
          const SizedBox(height: 8),
          _ActionButton(
            text: '로그아웃',
            onPressed: () => _showDialog(
              title: '로그아웃 안내',
              content: '로그아웃 하시겠습니까?',
              onConfirm: _logoutUser,
            ),
          ),
        ],
      ),
    );
  }
}
