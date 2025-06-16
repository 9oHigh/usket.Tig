import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:tig/ads/admob_service.dart';
import 'package:tig/core/manager/home_widget_manager.dart';
import 'package:tig/core/routes/app_route.dart';
import 'package:tig/data/models/tig.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tig/presentation/screens/home/provider/home_notifier_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  final TextEditingController _brainDumpController = TextEditingController();
  List<TextEditingController> _dailyPriorityControllers = [];
  Timer? _dateSwiperDebounceTimer;

  List<FocusNode> _dailyPriorityNodes = [];
  final FocusNode _braindumpNode = FocusNode();
  List<FocusNode> _activityFocusNodes = [];
  int? _focusedNodeIndex;

  bool isAtBottom = false;
  bool isDailySectionExpanded = true;

  @override
  void initState() {
    _initializeControllers();
    _initializeFocusNodes();
    super.initState();
  }

  void _initializeControllers() {
    _dailyPriorityControllers =
        List.generate(35, (index) => TextEditingController());
    _scrollController = ScrollController()
      ..addListener(() {
        final isAtBottom = _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent;
        if (this.isAtBottom != isAtBottom) {
          setState(() {
            this.isAtBottom = isAtBottom;
          });
        }
      });
  }

  void _initializeFocusNodes() {
    _dailyPriorityNodes = List.generate(3, (index) => FocusNode());
    _activityFocusNodes = List.generate(35, (index) {
      return FocusNode()
        ..addListener(() => _focusedNodeIndex =
            _activityFocusNodes[index].hasFocus ? index : _focusedNodeIndex);
    });
  }

  void _insertTextAtCursor(String text, Tig tig) {
    if (_focusedNodeIndex == null) return;

    final controller = _dailyPriorityControllers[_focusedNodeIndex!];
    final currentText = controller.text;
    final selection = controller.selection;
    final newText =
        currentText.replaceRange(selection.start, selection.end, text);

    controller.text = newText;
    tig.timeTable[_focusedNodeIndex!].activity = newText;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: selection.start + text.length));
  }

  void _moveToNextTextField() {
    if (_focusedNodeIndex! >= _dailyPriorityControllers.length - 1) {
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    }

    _focusedNodeIndex = _focusedNodeIndex! + 1;
    FocusScope.of(context)
        .requestFocus(_activityFocusNodes[_focusedNodeIndex!]);
  }

  Future<void> _showFullScreenAd() async {
    final homeNotifier = ref.read(homeNotifierProvider.notifier);
    final homeState = ref.watch(homeNotifierProvider);

    homeNotifier.loadAd();
    await Future.delayed(const Duration(seconds: 2));

    AdMobService.loadInterstitialAd(() {
      Navigator.of(context)
          .pushNamed(AppRoute.tigMode, arguments: homeState.tig!);
    }, () {
      homeNotifier.quitLoadAd();
    });
  }

  void _showDatePicker() async {
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: homeState.tig!.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) homeNotifier.setDateTime(selectedDate);
  }

  void _showSavedDialog() {
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

  void _showCurrentDate(BuildContext context, DateTime currentDate) {
    final formattedDate =
        "${currentDate.year}-${currentDate.month}-${currentDate.day}";

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Intl.message("home_swipe_date", args: [formattedDate])),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  void _onHorizontalDragUpdateWithDebounce(DragUpdateDetails details) {
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);
    _dateSwiperDebounceTimer?.cancel();
    _dateSwiperDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (details.delta.dx > 0) {
        final prevDate =
            homeState.currentDateTime.subtract(const Duration(days: 1));
        homeNotifier.setDateTime(prevDate);
        _showCurrentDate(context, prevDate);
      } else if (details.delta.dx < 0) {
        final nextDate = homeState.currentDateTime.add(const Duration(days: 1));
        homeNotifier.setDateTime(nextDate);
        _showCurrentDate(context, nextDate);
      }
    });
  }

  TextStyle _getLocaleTextStyle(BuildContext context) {
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
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      // 드래그 방향 감지
      onHorizontalDragUpdate: _onHorizontalDragUpdateWithDebounce,
      child: homeState.tig == null
          ? Center(
              child: CircularProgressIndicator(
              color: isDarkMode ? Colors.white : Colors.black,
            ))
          : Stack(
              children: [
                Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    title: const Text(
                      'TimeBox Planner',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoute.menu),
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  floatingActionButton:
                      KeyboardVisibilityBuilder(builder: (context, isVisible) {
                    return isVisible
                        ? const SizedBox.shrink()
                        : _buildFloatingActionButton();
                  }),
                  bottomSheet: KeyboardVisibilityBuilder(
                    builder: (context, isVisible) {
                      final FocusNode currentFocusNode =
                          FocusManager.instance.primaryFocus!;
                      final bool isActivityFocusNode =
                          _activityFocusNodes.contains(currentFocusNode);
                      return (isVisible && isActivityFocusNode)
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: 2.0,
                                left: 2.0,
                                right: 2.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: homeState.tags.map((tag) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 2.0, left: 2.0),
                                        child: TextButton(
                                          onPressed: () {
                                            _insertTextAtCursor(
                                                tag, homeState.tig!);
                                            _moveToNextTextField();
                                          },
                                          child: Text(tag),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  body: LayoutBuilder(
                    builder: (context, constraints) {
                      return KeyboardVisibilityBuilder(
                          builder: (context, isVisible) {
                        final FocusNode currentFocusNode =
                            FocusManager.instance.primaryFocus!;
                        final bool isActivityFocusNode =
                            _activityFocusNodes.contains(currentFocusNode);
                        final bool isOnDaily = homeState.isOnDaily;
                        final bool isOnBraindump = homeState.isOnBraindump;

                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: isVisible && isActivityFocusNode
                                  ? MediaQuery.of(context).viewInsets.bottom +
                                      20
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
                                    if (isOnDaily) ...[
                                      const SizedBox(height: 16.0),
                                      _buildExpandableSection()
                                    ],
                                    if (isOnBraindump) ...[
                                      const SizedBox(height: 16.0),
                                      _buildBrainDump()
                                    ],
                                    const SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Intl.message('end_time')),
                                        Text(Intl.message('success')),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    _buildTimeTable(),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final container =
                                                  ProviderContainer();
                                              await homeNotifier.saveTig();
                                              await HomeWidgetManager()
                                                  .updateWidgetData(container);
                                              container.dispose();
                                              _showSavedDialog();
                                            },
                                            child: Text(
                                                Intl.message('home_save_desc')),
                                          ),
                                        ),
                                        SizedBox(
                                          child: ElevatedButton.icon(
                                            icon: const ImageIcon(
                                              AssetImage(
                                                  "assets/images/play.png"),
                                              size: 10,
                                            ),
                                            onPressed: () async {
                                              await homeNotifier.saveTig();
                                              await _showFullScreenAd();
                                            },
                                            label:
                                                Text(Intl.message('tig_mode')),
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
                if (homeState.isAdLoading) ...[
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
            ),
    );
  }

  Widget _buildDateSelector() {
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);
    final tig = homeState.tig!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          iconAlignment: IconAlignment.end,
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: _showDatePicker,
          label: Text(DateFormat('yyyy-MM-dd').format(tig.date)),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12)),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoute.option).then((_) {
              homeNotifier.loadPreference();
            });
          },
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }

  Widget _buildBrainDump() {
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);
    _brainDumpController.text = homeState.tig!.brainDump;

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
            onChanged: (text) => homeNotifier.updateBraindump(text),
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            style: _getLocaleTextStyle(context).copyWith(color: Colors.black),
            decoration: InputDecoration(
              hintText: Intl.message('home_braindump_placeholder'),
              hintStyle: _getLocaleTextStyle(context),
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
    final homeNotifier = ref.read(homeNotifierProvider.notifier);

    return AnimatedOpacity(
      opacity: isAtBottom ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      child: Visibility(
        visible: !isAtBottom,
        child: Stack(
          children: [
            FloatingActionButton(
              backgroundColor: isDarkMode ? Colors.white : Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.tag).then((_) {
                  homeNotifier.loadTags();
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

  Widget _buildExpandableSection() {
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);
    final tig = homeState.tig!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Daily Priority Top3",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
                icon: Icon(isDailySectionExpanded
                    ? Icons.expand_less
                    : Icons.expand_more),
                onPressed: () => setState(() {
                      isDailySectionExpanded = !isDailySectionExpanded;
                    })),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubicEmphasized,
          child: Column(
            children: isDailySectionExpanded
                ? List.generate(tig.dayTopPriorities.length, (index) {
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
                            value: tig.dayTopPriorities[index].isSucceed,
                            onChanged: (value) {
                              homeNotifier.updateDayPriorityIsSucceed(
                                  index, value ?? false);
                            },
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: TextField(
                              focusNode: _dailyPriorityNodes[index],
                              minLines: 1,
                              maxLines: 2,
                              controller: TextEditingController(
                                  text: tig.dayTopPriorities[index].priority),
                              onTapOutside: (_) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              onChanged: (text) {
                                homeNotifier.updateDayPriority(index, text);
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

  String getFormattedTime(int hour, int minute, bool isTwelveHour) {
    if (!isTwelveHour) {
      return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    }

    final period = hour >= 12 ? "PM" : "AM";
    final formattedHour = (hour % 12 == 0) ? 12 : hour % 12;

    return "${formattedHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
  }

  Widget _buildTimeTable() {
    final homeState = ref.watch(homeNotifierProvider);
    final homeNotifier = ref.read(homeNotifierProvider.notifier);
    final Tig tig = homeState.tig!;
    final List<double> timeSlots =
        List.generate(35, (index) => 7.0 + index * 0.5);

    return Column(
      children: timeSlots.map((timeSlot) {
        final int hour = timeSlot.floor();
        final int minute = (timeSlot - hour) == 0.5 ? 30 : 0;
        final index = timeSlots.indexOf(timeSlot);
        final bool success = tig.timeTable.length > index
            ? tig.timeTable[index].isSucceed
            : false;
        final String activity = tig.timeTable[index].activity;
        final timeText =
            getFormattedTime(hour, minute, homeState.isTwelveTimeSystem);

        _dailyPriorityControllers[index].text = activity;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(timeText),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                focusNode: _activityFocusNodes[index],
                controller: _dailyPriorityControllers[index],
                onChanged: (text) {
                  tig.timeTable[index].activity = text;
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
                  homeNotifier.updateActivityIsSucceed(index, value ?? false);
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
