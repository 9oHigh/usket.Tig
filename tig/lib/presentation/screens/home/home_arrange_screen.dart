import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';

enum ArrangeType { isOnDaily, isOnBraindump }

extension on ArrangeType {
  String get arrangeName {
    switch (this) {
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
  bool _isOnDaily = true;
  bool _isOnBraindump = true;

  @override
  void initState() {
    super.initState();
    _initailizeOptions();
  }

  void _initailizeOptions() async {
    setState(() {
      _isOnDaily =
          SharedPreferenceManager().getPref<bool>(PrefsType.isOnDaily) ?? false;
      _isOnBraindump =
          SharedPreferenceManager().getPref<bool>(PrefsType.isOnBraindump) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Intl.message('home_arrange_title'),
        ),
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
                  Text(
                    'Daily Priority',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Switch(
                          value: _isOnDaily,
                          onChanged: (value) async {
                            await SharedPreferenceManager()
                                .setPref<bool>(PrefsType.isOnDaily, value);
                            setState(() {
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
                  Text(
                    'Braindump',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Switch(
                          value: _isOnBraindump,
                          onChanged: (value) async {
                            await SharedPreferenceManager()
                                .setPref<bool>(PrefsType.isOnBraindump, value);
                            setState(() {
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
