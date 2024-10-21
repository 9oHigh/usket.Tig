import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/ads/admob_service.dart';
import 'package:tig/core/manager/home_widget_manager.dart';
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
  List<String> tags = [];

  List<FocusNode> _focusNodes = [];
  List<FocusNode> _dailyPrioritysNodes = [];
  FocusNode _braindumpNode = FocusNode();
  int? _focusNodeIndex;

  late ScrollController _scrollController;
  late AnimationController _animationController;
  late TextEditingController _brainDumpController;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
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

    _initailizeFocusNodes();
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

  _initailizeFocusNodes() {
    _dailyPrioritysNodes = List.generate(3, (index) {
      return FocusNode();
    });
    _braindumpNode = FocusNode();
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

  _showFullScreenAd() async {
    setState(() {
      _fullAdIsLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
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

  _showSavedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: Center(child: Text(Intl.message('home_save_completed'))),
        content: Text(
          Intl.message("home_save_completed_desc"),
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(Intl.message('ok')),
          ),
        ],
      ),
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    Localizations.localeOf(context);
    if (currentLocale.languageCode == 'ja') {
      return TextStyle(
          fontFamily: 'ShigotoMemogaki', fontSize: 22, color: Colors.grey[600]);
    } else if (currentLocale.languageCode == 'zh') {
      return TextStyle(
          fontFamily: "CangJiGaoDeGuoMiaoHei",
          fontSize: 16,
          color: Colors.grey[600]);
    } else {
      return TextStyle(
          fontFamily: 'NanumBrush', fontSize: 22, color: Colors.grey[600]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text(
              'TimeBox Planner',
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
              FocusNode currentFocus = FocusManager.instance.primaryFocus!;
              bool isOtherFocusNodeFocused =
                  !_focusNodes.contains(currentFocus);
              if (isVisible && !isOtherFocusNodeFocused) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 2.0,
                    left: 2.0,
                    right: 2.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: tags.map((tag) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(right: 2.0, left: 2.0),
                            child: TextButton(
                              onPressed: () {
                                _insertTextAtCursor(tag);
                                _moveToNextTextField();
                              },
                              child: Text(tag),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return KeyboardVisibilityBuilder(builder: (context, isVisible) {
                FocusNode currentFocus = FocusManager.instance.primaryFocus!;
                bool isOtherFocusNodeFocused =
                    !_focusNodes.contains(currentFocus);
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: isVisible && !isOtherFocusNodeFocused
                          ? MediaQuery.of(context).viewInsets.bottom + 20
                          : 0),
                  child: Column(
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
                                "Daily Priority Top3",
                                _isDayExpanded,
                                () => setState(
                                    () => _isDayExpanded = !_isDayExpanded),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Intl.message('end_time')),
                                Text(Intl.message('success')),
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
                                    onPressed: () async {
                                      await _saveTigData();
                                      await HomeWidgetManager()
                                          .updateWidgetData();
                                      _showSavedDialog();
                                    },
                                    child: Text(Intl.message('home_save_desc')),
                                  ),
                                ),
                                SizedBox(
                                  child: ElevatedButton.icon(
                                    icon: const ImageIcon(
                                      AssetImage("assets/images/play.png"),
                                      size: 10,
                                    ),
                                    onPressed: () async {
                                      await _saveTigData();
                                      await _showFullScreenAd();
                                    },
                                    label: Text(Intl.message('tig_mode')),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          ),
        ),
        if (_fullAdIsLoading) ...[
          AbsorbPointer(
            absorbing: true,
            child: Container(
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Intl.message('home_tig_mode_prepare'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CircularProgressIndicator(
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
          "Braindump",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/post_it.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: TextField(
            focusNode: _braindumpNode,
            cursorColor: Colors.black,
            cursorHeight: 16,
            cursorWidth: 1.5,
            controller: _brainDumpController,
            maxLines: 8,
            minLines: 1,
            onChanged: (text) => setState(() {}),
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            style: _getTextStyle(context).copyWith(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: Intl.message('home_braindump_placeholder'),
              hintStyle: _getTextStyle(context),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.only(
                  left: 36, top: 52, bottom: 72, right: 40),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AnimatedOpacity(
      opacity: _isAtBottom ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      child: Visibility(
        visible: !_isAtBottom,
        child: Stack(
          children: [
            FloatingActionButton(
              backgroundColor: isDarkMode ? Colors.white : Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.tag).then((_) {
                  _loadTags();
                });
              },
              child: Icon(
                Icons.tag_rounded,
                size: 32,
                color: isDarkMode ? Colors.black : Colors.white,
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
                              focusNode: _dailyPrioritysNodes[index],
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
                decoration: InputDecoration(
                  hintText: Intl.message('home_activity_placeholder'),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
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
            ),
          ],
        );
      }).toList(),
    );
  }
}
