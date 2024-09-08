import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tig/models/tig.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isMonthExpanded = false;
  bool _isWeekExpanded = false;
  bool _isDayExpanded = false;
  bool _isFabExpanded = false;
  bool _isAtBottom = false;

  late Tig tigData;
  late ScrollController _scrollController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    tigData = Tig(
      date: DateTime.now(),
      monthTopPriorites: ["Priority 1", "Priority 2", "Priority 3"],
      weekTopPriorites: ["Weekly 1", "Weekly 2", "Weekly 3"],
      dayTopPriorites: ["Daily 1", "Daily 2", "Daily 3"],
      timeTable: [
        TimeEntry(activity: "Meeting", time: 1.5),
        TimeEntry(activity: "Coding", time: 2.0),
      ],
      timeTableSuccessed: [true, false],
    );

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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
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
        floatingActionButton: AnimatedOpacity(
          opacity: _isAtBottom ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              if (_isFabExpanded) ...[
                _buildFloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.red,
                  icon: Icons.calendar_today,
                  bottomPosition: 80,
                ),
                _buildFloatingActionButton(
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
        ),
        body: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildDateSelector(),
            const SizedBox(height: 16.0),
            _buildExpandableSection(
              "Monthly priority top3",
              _isMonthExpanded,
              () => setState(() => _isMonthExpanded = !_isMonthExpanded),
              tigData.monthTopPriorites,
            ),
            const SizedBox(height: 16.0),
            _buildExpandableSection(
              "Weekly priority top3",
              _isWeekExpanded,
              () => setState(() => _isWeekExpanded = !_isWeekExpanded),
              tigData.weekTopPriorites,
            ),
            const SizedBox(height: 16.0),
            _buildExpandableSection(
              "Daily priority top3",
              _isDayExpanded,
              () => setState(() => _isDayExpanded = !_isDayExpanded),
              tigData.dayTopPriorites,
            ),
            const SizedBox(height: 16.0),
            _buildBrainDump(),
            const SizedBox(height: 16.0),
            _buildTimeTable(),
            const SizedBox(height: 16.0),
            ElevatedButton(onPressed: () {
              // 회고 화면 이동
            }, child: const Text('회고 하기'))
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
          label: Text(
            DateFormat('yyyy-MM-dd').format(tigData.date),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(left: 12, right: 6),
          ),
        ),
        IconButton(
          onPressed: () {},
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
          maxLines: null,
          controller: TextEditingController(text: tigData.brainDump),
          onChanged: (text) => setState(() => tigData.brainDump = text),
          decoration: const InputDecoration(
            hintText: "Spill out whatever comes to your mind!",
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton({
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
      setState(() => tigData.date = selectedDate);
    }
  }

  Widget _buildExpandableSection(
    String title,
    bool isExpanded,
    VoidCallback onToggle,
    List<String> priorities,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
                ? priorities.map((priority) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: TextField(
                        controller: TextEditingController(text: priority),
                        onChanged: (text) {
                          final index = priorities.indexOf(priority);
                          setState(() {
                            priorities[index] = text;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
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
        List.generate(33, (index) => 7 + index * 0.5);

    return Column(
      children: timeSlots.map((timeSlot) {
        final int hour = timeSlot.floor();
        final int minute = (timeSlot - hour) == 0.5 ? 30 : 0;

        TimeEntry? timeEntry = tigData.timeTable.firstWhere(
          (entry) => entry.time == timeSlot,
          orElse: () => TimeEntry(activity: "", time: timeSlot),
        );

        final bool success =
            tigData.timeTableSuccessed.length > timeSlots.indexOf(timeSlot)
                ? tigData.timeTableSuccessed[timeSlots.indexOf(timeSlot)]
                : false;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}",
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                // padding: const EdgeInsets.only(bottom: 4),
                child: TextField(
                  controller: TextEditingController(text: timeEntry.activity),
                  onChanged: (text) {
                    setState(() {
                      timeEntry.activity = text;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter activity",
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
            ),
            Checkbox(
              value: success,
              onChanged: (bool? value) {
                setState(() {
                  tigData.timeTableSuccessed[timeSlots.indexOf(timeSlot)] =
                      value ?? false;
                });
              },
            ),
          ],
        );
      }).toList(),
    );
  }
}
