import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ArrangeType { isOnMonthly, isOnWeekly, isOnDaily, isOnBraindump }

extension on ArrangeType {
  String get arrangeName {
    switch (this) {
      case ArrangeType.isOnMonthly:
        return 'isOnMonthly';
      case ArrangeType.isOnWeekly:
        return 'isOnWeekly';
      case ArrangeType.isOnDaily:
        return 'isOnDaily';
      case ArrangeType.isOnBraindump:
        return 'isOnBraindump';
    }
  }
}

class HomeArrangeScreen extends StatefulWidget {
  const HomeArrangeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeArrangeScreen();
}

class _HomeArrangeScreen extends State<HomeArrangeScreen> {
  bool _isOnMonthly = false;
  bool _isOnWeekly = false;
  bool _isOnDaily = false;
  bool _isOnBraindump = false;

  @override
  void initState() {
    super.initState();
    initailizeOptions();
  }

  void initailizeOptions() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _isOnMonthly = pref.getBool('isOnMonthly') ?? false;
      _isOnWeekly = pref.getBool('isOnWeekly') ?? false;
      _isOnDaily = pref.getBool('isOnDaily') ?? false;
      _isOnBraindump = pref.getBool('isOnBraindump') ?? false;
    });
  }

  void setPref(ArrangeType type, bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(type.arrangeName, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Monthly priority'),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoSwitch(
                          value: _isOnMonthly,
                          onChanged: (value) {
                            setState(() {
                              setPref(ArrangeType.isOnMonthly, value);
                              _isOnMonthly = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Weekly priority'),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoSwitch(
                          value: _isOnWeekly,
                          onChanged: (value) {
                            setState(() {
                              setPref(ArrangeType.isOnWeekly, value);
                              _isOnWeekly = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Daily priority'),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoSwitch(
                          value: _isOnDaily,
                          onChanged: (value) {
                            setState(() {
                              setPref(ArrangeType.isOnDaily, value);
                              _isOnDaily = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Braindump'),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoSwitch(
                          value: _isOnBraindump,
                          onChanged: (value) {
                            setState(() {
                              setPref(ArrangeType.isOnBraindump, value);
                              _isOnBraindump = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
