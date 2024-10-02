import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/providers/tig/tig_provider.dart';

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

    await saveMonthlyTigsToPreferences(monthlyTigs);
    await saveTodayTigsToPreferences(monthlyTigs);

    setState(() {
      _monthlyTigs = monthlyTigs;
    });
  }

  Future<void> saveMonthlyTigsToPreferences(List<Tig> monthlyTigs) async {
    final monthlyTigsJson = jsonEncode(
      monthlyTigs.map((tig) {
        var tigMap = tig.toMap();
        tigMap['date'] = tig.date.toIso8601String();
        return tigMap;
      }).toList(),
    );

    await HomeWidget.saveWidgetData<int>("current_month", _currentDate.month);
    await HomeWidget.saveWidgetData<String>("monthly_tigs", monthlyTigsJson);
    await HomeWidget.updateWidget(
      name: 'LargeWidgetProvider',
      androidName: 'LargeWidgetProvider',
    );
  }

  Future<void> saveTodayTigsToPreferences(List<Tig> monthlyTigs) async {
    final today = DateTime.now();
    Tig? todayTig;

    for (var tig in monthlyTigs) {
      if (tig.date.year == today.year &&
          tig.date.month == today.month &&
          tig.date.day == today.day) {
        todayTig = tig;
        break;
      }
    }

    if (todayTig != null) {
      final todayTigJson = jsonEncode({
        ...todayTig.toMap(),
        'date': todayTig.date.toIso8601String(),
      });

      await HomeWidget.saveWidgetData<int>("current_day", _currentDate.day);
      await HomeWidget.saveWidgetData<String>("today_tig", todayTigJson);
      await HomeWidget.updateWidget(
        name: 'SmallWidgetProvider',
        androidName: 'SmallWidgetProvider',
      );
    } else {
      await HomeWidget.saveWidgetData<int>("current_day", _currentDate.day);
      await HomeWidget.saveWidgetData<String>("today_tig", null);
      await HomeWidget.updateWidget(
        name: 'SmallWidgetProvider',
        androidName: 'SmallWidgetProvider',
      );
    }
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

  _sendEmail() async {
    String body = "";
    body += "아래의 내용을 함께 보내주시면 큰 도움이 됩니다😊\n";
    body += "사용 중인 스마트폰: \n";
    body += "오류 혹은 개선점: \n\n\n";
    body += "이 외에 문의할 것이 있다면 편하게 작성해주세요 :)\n";
    final Email email = Email(
      subject: "문의드립니다.",
      body: body,
      recipients: ['usket@icloud.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '설정',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${_currentDate.month} 월 Tigs',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 250,
              width: MediaQuery.sizeOf(context).width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount:
                    DateTime(_currentDate.year, _currentDate.month + 1, 0)
                        .day,
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final tigForDay = _monthlyTigs.firstWhere(
                    (tig) => tig.date.day == day,
                    orElse: () => Tig(
                      date: DateTime(
                        _currentDate.year,
                        _currentDate.month,
                        day,
                      ),
                      timeTable: [],
                    ),
                  );
                  return Container(
                    decoration: BoxDecoration(
                      color: _getColorForGrade(
                        tigForDay.grade,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          color:
                              tigForDay.grade > 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    '구독하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Text('490₩/월 '),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: const Color.fromARGB(255, 244, 242, 236),
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Center(
                      child: Text(
                        '구독하면 이런게 생겨요!\n화면에 표시되는 모든 광고가 제거됩니다😊',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        '구독하면 이런게 생겨요!\n얼마나 열심히 진행하는지 한 눈에 볼 수 있게 위젯을 제공해요😊',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        '구독하면 이런게 생겨요!\n개발자가 더 나은 앱을 만들어갈 수 있는\n 원동력을 주실 수 있어요😊\n반드시 보답할게요!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  onPageChanged: (value) {
                    setState(() {
                      _currentSubscribePage = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  width: _currentSubscribePage == index ? 12 : 8,
                  height: _currentSubscribePage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    color: _currentSubscribePage == index
                        ? Colors.black
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _sendEmail,
                  child: const Text(
                    '문의 하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
