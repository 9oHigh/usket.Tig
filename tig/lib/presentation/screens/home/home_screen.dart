import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/ads/admob_service.dart';
import 'package:tig/core/routes/app_route.dart';
import 'package:tig/data/models/tig.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/providers/tig/tig_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isDayExpanded = true;
  bool _isAtBottom = false;
  bool _isOnDaily = true;
  bool _isOnBraindump = true;
  bool _fullAdIsLoading = false;

  late String _userId;
  late DateTime _dateTime;
  late Tig tigData = Tig(date: DateTime.now());
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];
  int? _focusNodeIndex;
  List<String> tags = [];

  late ScrollController _scrollController;
  late AnimationController _animationController;
  late TextEditingController _brainDumpController;

  @override
  void initState() {
    super.initState();

    _userId = FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';

    _scrollController = ScrollController()
      ..addListener(() {
        final isAtBottom = _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent;
        if (isAtBottom != _isAtBottom) {
          setState(() => _isAtBottom = isAtBottom);
        }
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _brainDumpController = TextEditingController();

    _dateTime = DateTime.now();

    _loadTigData();

    _loadTags();

    _loadPreferences();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _brainDumpController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loadTigData() async {
    final tigUsecase = ref.read(tigUseCaseProvider);
    final fetchedData = await tigUsecase.getTigData(_userId, _dateTime);

    tigData = fetchedData ?? Tig(date: _dateTime);
    _brainDumpController.text = tigData.brainDump;

    setState(() {
      _setTimeTableControllers();
    });
  }

  Future<void> _saveTigData() async {
    final tigUsecase = ref.read(tigUseCaseProvider);
    await tigUsecase.saveTigData(_userId, tigData);
  }

  Future<void> _loadTags() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      tags = pref.getStringList('tags') ?? [];
    });
  }

  Future<void> _loadPreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _isOnDaily = pref.getBool('isOnDaily') ?? true;
      _isOnBraindump = pref.getBool('isOnBraindump') ?? true;
    });
  }

  _setTimeTableControllers() {
    _controllers = List.generate(35, (index) {
      final activity = tigData.timeTable[index].activity;
      return TextEditingController(text: activity);
    });

    _focusNodes = List.generate(35, (index) {
      return FocusNode()
        ..addListener(() {
          if (_focusNodes[index].hasFocus) {
            setState(() {
              _focusNodeIndex = index;
            });
          }
        });
    });
  }

  _insertTextAtCursor(String text) {
    if (_focusNodeIndex != null) {
      final controller = _controllers[_focusNodeIndex!];
      final currentText = controller.text;
      final selection = controller.selection;

      if (selection.start >= 0) {
        final newText = currentText.replaceRange(
          selection.start,
          selection.end,
          text,
        );

        controller.text = newText;
        tigData.timeTable[_focusNodeIndex!].activity = newText;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: selection.start + text.length),
        );
      }
    }
  }

  void _moveToNextTextField() {
    if (_focusNodeIndex != null && _focusNodeIndex! < _controllers.length - 1) {
      _focusNodes[_focusNodeIndex!].unfocus();
      _focusNodeIndex = _focusNodeIndex! + 1;
      FocusScope.of(context).requestFocus(_focusNodes[_focusNodeIndex!]);
    }
  }

  _showFullScreenAd() {
    setState(() {
      _fullAdIsLoading = true;
    });
    Future.delayed(const Duration(seconds: 3));
    AdMobService.loadInterstitialAd(
        () => _pushTigModeScreen(context), _setFullAdLoaded);
  }

  _setFullAdLoaded() {
    setState(() {
      _fullAdIsLoading = false;
    });
  }

  _pushTigModeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoute.tigMode,
      arguments: tigData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text(
              'Time Box Planner',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.menu);
                },
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
          floatingActionButton:
              KeyboardVisibilityBuilder(builder: (context, isVisible) {
            if (isVisible) {
              return const SizedBox.shrink();
            } else {
              return _buildFloatingActionButton();
            }
          }),
          bottomSheet: KeyboardVisibilityBuilder(
            builder: (context, isVisible) {
              if (isVisible) {
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 44,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: tags.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Center(
                                          child: TextButton(
                                        onPressed: () {
                                          _insertTextAtCursor(tags[index]);
                                        },
                                        child: Text(
                                          tags[index],
                                        ),
                                      )),
                                    );
                                  }),
                            ),
                            IconButton(
                              onPressed: () => _moveToNextTextField(),
                              icon: const Icon(Icons.arrow_downward),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildDateSelector(),
                    if (_isOnDaily) ...{
                      const SizedBox(height: 16.0),
                      _buildExpandableSection(
                        "Daily priority top3",
                        _isDayExpanded,
                        () => setState(() => _isDayExpanded = !_isDayExpanded),
                        tigData.dayTopPriorities,
                        (index, value) {
                          setState(() {
                            tigData.dayTopPriorities[index].priority =
                                value.priority;
                            tigData.dayTopPriorities[index].isSucceed =
                                value.isSucceed;
                          });
                        },
                      ),
                    },
                    if (_isOnBraindump) ...{
                      const SizedBox(height: 16.0),
                      _buildBrainDump(),
                    },
                    const SizedBox(height: 16.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('End Time'),
                        Text('Success'),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    _buildTimeTable(),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              _saveTigData();
                            },
                            child: const Text('저장 하기'),
                          ),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              _saveTigData();
                              _showFullScreenAd();
                            },
                            child: const Text('티그 모드'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_fullAdIsLoading) ...[
          AbsorbPointer(
            absorbing: true,
            child: Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "티그 모드를 위해 데이터를 준비중이에요.\n준비되는 동안 광고가 나와요.\n잠시만 기다려주시면 멋진 티그모드를 만날 수 있어요!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDateSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          iconAlignment: IconAlignment.end,
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: _showDatePicker,
          label: Text(DateFormat('yyyy-MM-dd').format(tigData.date)),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12)),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoute.arrange).then((_) {
              _loadPreferences();
            });
          },
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }

  Widget _buildBrainDump() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Brain dump",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _brainDumpController,
          onChanged: (text) => setState(() => tigData.brainDump = text),
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          decoration: const InputDecoration(
            hintText: "Spill out whatever comes to your mind!",
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return AnimatedOpacity(
      opacity: _isAtBottom ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      child: Visibility(
        visible: !_isAtBottom,
        child: Stack(
          children: [
            FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.tag).then((_) {
                  _loadTags();
                });
              },
              child: const Icon(
                Icons.tag_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: tigData.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _dateTime = selectedDate;
        _loadTigData();
      });
    }
  }

  Widget _buildExpandableSection(
    String title,
    bool isExpanded,
    VoidCallback onToggle,
    List<PriorityEntry> priorities,
    Function(int, PriorityEntry) onPriorityChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: onToggle,
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubicEmphasized,
          child: Column(
            children: isExpanded
                ? List.generate(priorities.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            value: priorities[index].isSucceed,
                            onChanged: (value) {
                              setState(() {
                                priorities[index].isSucceed =
                                    !priorities[index].isSucceed;
                                tigData.dayTopPriorities[index].priority =
                                    priorities[index].priority;
                                tigData.dayTopPriorities[index].isSucceed =
                                    priorities[index].isSucceed;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: TextField(
                              minLines: 1,
                              maxLines: 2,
                              controller: TextEditingController(
                                text: priorities[index].priority,
                              ),
                              onTapOutside: (event) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              onChanged: (text) {
                                priorities[index].priority = text;
                                tigData.dayTopPriorities[index].priority =
                                    priorities[index].priority;
                                tigData.dayTopPriorities[index].isSucceed =
                                    priorities[index].isSucceed;
                              },
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()
                : [],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeTable() {
    final List<double> timeSlots =
        List.generate(35, (index) => 7.0 + index * 0.5);

    if (_focusNodes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: timeSlots.map((timeSlot) {
        final int hour = timeSlot.floor();
        final int minute = (timeSlot - hour) == 0.5 ? 30 : 0;
        final bool success =
            tigData.timeTable.length > timeSlots.indexOf(timeSlot)
                ? tigData.timeTable[timeSlots.indexOf(timeSlot)].isSucceed
                : false;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}"),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                focusNode: _focusNodes[timeSlots.indexOf(timeSlot)],
                controller: _controllers[timeSlots.indexOf(timeSlot)],
                onChanged: (text) {
                  final index = tigData.timeTable.indexWhere(
                    (entry) => entry.time == timeSlot,
                  );
                  tigData.timeTable[index].activity = text;
                },
                decoration: const InputDecoration(
                  hintText: "Enter activity",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Checkbox(
              value: success,
              onChanged: (bool? value) {
                setState(() {
                  final index = tigData.timeTable.indexWhere(
                    (entry) => entry.time == timeSlot,
                  );
                  tigData.timeTable[index].isSucceed = value ?? false;
                });
              },
            ),
          ],
        );
      }).toList(),
    );
  }
}
