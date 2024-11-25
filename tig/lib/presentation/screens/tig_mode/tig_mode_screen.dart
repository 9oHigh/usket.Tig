import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/core/manager/home_widget_manager.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/data/models/time_entry.dart';
import 'package:tig/presentation/providers/tig/tig_provider.dart';
import 'package:tig/presentation/widgets/styles/circular_count_down_painter.dart';

class TigModeScreen extends ConsumerStatefulWidget {
  final Tig tig;

  const TigModeScreen({super.key, required this.tig});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TigModeScreenState();
}

class _TigModeScreenState extends ConsumerState<TigModeScreen> {
  TimeEntry? _currentTimeEntry;
  Timer? _timer;
  bool _isWaiting = false;

  late Tig _tig;
  late int _remainSeconds;

  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _tig = widget.tig;
    _initializeTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeTimer() {
    final int currentIndex = _getCurrentEntryIndex();
    if (currentIndex != -1) {
      _currentTimeEntry = _tig.timeTable[currentIndex];
      _calculateTimes();
      _remainSeconds = _endTime.difference(DateTime.now()).inSeconds;
      _startWaitingOrCountdown();
    }
  }

  int _getCurrentEntryIndex() {
    final DateTime now = DateTime.now();
    final double currentTime = now.hour + (now.minute >= 30 ? 0.5 : 0);

    for (int i = 0; i < _tig.timeTable.length; i++) {
      final timeEntry = _tig.timeTable[i];
      final double entryEndTime = timeEntry.time;
      final double entryStartTime = entryEndTime - 0.5;

      if (currentTime >= entryStartTime &&
          currentTime < entryEndTime &&
          timeEntry.activity.isNotEmpty) {
        return i;
      }
    }
    return -1;
  }

  void _calculateTimes() {
    final entryEndTime = _currentTimeEntry!.time;
    final entryStartTime = entryEndTime - 0.5;

    _startTime = _createDateTime(entryStartTime);
    _endTime = _createDateTime(entryEndTime);
  }

  DateTime _createDateTime(double time) {
    final now = DateTime.now();
    final hour = time.floor();
    final minute = ((time % 1) * 60).round();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  void _startWaitingOrCountdown() {
    final now = DateTime.now();
    if (now.isBefore(_startTime)) {
      _isWaiting = true;
      _startWaitingTimer();
    } else if (now.isBefore(_endTime)) {
      _isWaiting = false;
      _startCountdownTimer();
    } else {
      _moveToNextEntry();
    }
  }

  void _startWaitingTimer() {
    _timer?.cancel();
    _timer = Timer(_startTime.difference(DateTime.now()), () {
      setState(() {
        _isWaiting = false;
      });
      _startCountdownTimer();
    });
  }

  void _startCountdownTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          if (_remainSeconds > 0) {
            _remainSeconds--;
          } else {
            _moveToNextEntry();
          }
        });
      },
    );
  }

  void _moveToNextEntry() {
    setState(() {
      final nextIndex = _getNextEntryIndex();
      if (nextIndex != null) {
        _currentTimeEntry = _tig.timeTable[nextIndex];
        _calculateTimes();
        _remainSeconds = 30 * 60;
        _startWaitingOrCountdown();
      } else {
        _currentTimeEntry = null;
        _timer?.cancel();
      }
    });
  }

  int? _getNextEntryIndex() {
    final currentIndex = _tig.timeTable.indexOf(_currentTimeEntry!);
    for (int i = currentIndex + 1; i < _tig.timeTable.length; i++) {
      final entry = _tig.timeTable[i];
      if (entry.activity.isNotEmpty) {
        return i;
      }
    }
    return null;
  }

  String _getUserId() {
    return SharedPreferenceManager().getPref<String>(PrefsType.userId) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _currentTimeEntry == null
            ? _buildNoEntryWidget()
            : _buildEntryWidget(),
      ),
    );
  }

  Widget _buildNoEntryWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 32,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            Intl.message('tig_mode_empty_tig'),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {
              _timer?.cancel();
              Navigator.pop(context);
            },
            child: Text(Intl.message('exit')),
          )
        ],
      ),
    );
  }

  Widget _buildEntryWidget() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Intl.message('tig_mode_start_time', args: [
                  "${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}"
                ]),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                Intl.message('tig_mode_end_time', args: [
                  "${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}"
                ]),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth * 0.8;
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey.withAlpha(125)
                    : Colors.grey.withAlpha(75),
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Text(
                '${_currentTimeEntry?.activity}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ),
        const SizedBox(height: 32),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(200, 200),
              painter: CircularCountdownPainter(
                  _remainSeconds / (30 * 60), isDarkMode),
            ),
            Column(
              children: [
                Text(
                  _isWaiting
                      ? Intl.message('tig_mode_waiting')
                      : Intl.message('tig_mode_remain_time'),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  Intl.message('tig_mode_count_down', args: [
                    ((_remainSeconds ~/ 60).toString()),
                    ((_remainSeconds % 60).toString().padLeft(2, '0'))
                  ]),
                  style: const TextStyle(
                      fontFamily: 'PaperlogyExtraBold', fontSize: 24),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _timer?.cancel();
                Navigator.pop(context);
              },
              child: Text(Intl.message('end')),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () async {
                if (_currentTimeEntry != null) {
                  final tigProvider = ref.read(tigUseCaseProvider);
                  final container = ProviderContainer();
                  final userId = _getUserId();
                  _currentTimeEntry!.isSucceed = true;
                  await tigProvider.saveTigData(userId, _tig);
                  await HomeWidgetManager().updateWidgetData(container);
                  container.dispose();
                  _moveToNextEntry();
                }
              },
              child: Text(Intl.message('next')),
            ),
          ],
        ),
      ],
    );
  }
}
