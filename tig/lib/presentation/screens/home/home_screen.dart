import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isMonthExpanded = false;
  bool _isWeekExpanded = false;
  bool _isDayExpanded = false;
  bool _isFabExpanded = false;
  bool _isAtBottom = false;
  bool _isOnMonthly = true;
  bool _isOnWeekly = true;
  bool _isOnDaily = true;
  bool _isOnBraindump = true;

  late Tig tigData = Tig(date: DateTime.now());
  late DateTime _dateTime;
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late TextEditingController _brainDumpController;
  late String _userId;

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

    _loadPreferences();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _brainDumpController.dispose();
    super.dispose();
  }

  Future<void> _loadTigData() async {
    final tigUsecase = ref.read(tigUseCaseProvider);
    final fetchedData = await tigUsecase.getTigData(_userId, _dateTime);

    setState(() {
      tigData = fetchedData ?? Tig(date: _dateTime);
      _brainDumpController.text = tigData.brainDump;
    });
  }

  Future<void> _saveTigData() async {
    final tigUsecase = ref.read(tigUseCaseProvider);
    await tigUsecase.saveTigData(_userId, tigData);
  }

  Future<void> _loadPreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _isOnMonthly = pref.getBool('isOnMonthly') ?? true;
      _isOnWeekly = pref.getBool('isOnWeekly') ?? true;
      _isOnDaily = pref.getBool('isOnDaily') ?? true;
      _isOnBraindump = pref.getBool('isOnBraindump') ?? true;
    });
  }

  void pushTigModeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoute.tigMode,
      arguments: tigData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Time Box Planner',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(),
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
                  const SizedBox(height: 16.0),
                  if (_isOnMonthly)
                    _buildExpandableSection(
                      "Monthly priority top3",
                      _isMonthExpanded,
                      () =>
                          setState(() => _isMonthExpanded = !_isMonthExpanded),
                      tigData.monthTopPriorities,
                      (index, value) {
                        setState(() {
                          tigData.monthTopPriorities[index] = value;
                        });
                      },
                    ),
                  const SizedBox(height: 16.0),
                  if (_isOnWeekly)
                    _buildExpandableSection(
                      "Weekly priority top3",
                      _isWeekExpanded,
                      () => setState(() => _isWeekExpanded = !_isWeekExpanded),
                      tigData.weekTopPriorities,
                      (index, value) {
                        setState(() {
                          tigData.weekTopPriorities[index] = value;
                        });
                      },
                    ),
                  const SizedBox(height: 16.0),
                  if (_isOnDaily)
                    _buildExpandableSection(
                      "Daily priority top3",
                      _isDayExpanded,
                      () => setState(() => _isDayExpanded = !_isDayExpanded),
                      tigData.dayTopPriorities,
                      (index, value) {
                        setState(() {
                          tigData.dayTopPriorities[index] = value;
                        });
                      },
                    ),
                  const SizedBox(height: 16.0),
                  if (_isOnBraindump) _buildBrainDump(),
                  const SizedBox(height: 16.0),
                  _buildTimeTable(),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        _saveTigData();
                        pushTigModeScreen(context);
                      },
                      child: const Text('시작 하기'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        const Text("Brain dump"),
        const SizedBox(height: 8),
        TextField(
          controller: _brainDumpController,
          onChanged: (text) => setState(() => tigData.brainDump = text),
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
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          if (_isFabExpanded) ...[
            _buildFloatingActionButtonItem(
              onPressed: () {},
              backgroundColor: Colors.red,
              icon: Icons.calendar_today,
              bottomPosition: 80,
            ),
            _buildFloatingActionButtonItem(
              onPressed: () {},
              backgroundColor: Colors.blue,
              icon: Icons.add,
              bottomPosition: 150,
            ),
          ],
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _isFabExpanded = !_isFabExpanded;
                _isFabExpanded
                    ? _animationController.forward()
                    : _animationController.reverse();
              });
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animationController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButtonItem({
    required VoidCallback onPressed,
    required Color backgroundColor,
    required IconData icon,
    required double bottomPosition,
  }) {
    return Positioned(
      bottom: bottomPosition,
      child: FloatingActionButton(
        onPressed: onPressed,
        mini: true,
        backgroundColor: backgroundColor,
        child: Icon(icon),
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
    List<String> priorities,
    Function(int, String) onPriorityChanged,
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
                      child: TextField(
                        controller:
                            TextEditingController(text: priorities[index]),
                        onChanged: (text) {
                          onPriorityChanged(index, text);
                        },
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
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
    final List<double> timeSlots = List.generate(48, (index) => index * 0.5);

    return Column(
      children: timeSlots.map((timeSlot) {
        final int hour = timeSlot.floor();
        final int minute = (timeSlot - hour) == 0.5 ? 30 : 0;

        TimeEntry? timeEntry = tigData.timeTable.firstWhere(
          (entry) => entry.time == timeSlot,
          orElse: () =>
              TimeEntry(activity: "", time: timeSlot, isSucceed: true),
        );

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
                controller: TextEditingController(text: timeEntry.activity),
                onChanged: (text) {
                  setState(
                    () {
                      final index = tigData.timeTable.indexWhere(
                        (entry) => entry.time == timeSlot,
                      );
                      if (index != -1) {
                        tigData.timeTable[index].activity = text;
                      } else {
                        tigData.timeTable.add(
                          TimeEntry(
                            activity: text,
                            time: timeSlot,
                            isSucceed: false,
                          ),
                        );
                      }
                    },
                  );
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
                  if (index != -1) {
                    tigData.timeTable[index].isSucceed = value ?? false;
                  } else {
                    tigData.timeTable.add(TimeEntry(
                      activity: "",
                      time: timeSlot,
                      isSucceed: value ?? false,
                    ));
                  }
                });
              },
            ),
          ],
        );
      }).toList(),
    );
  }
}
