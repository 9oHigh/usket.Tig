import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/providers/tig/tig_provider.dart';

class TigModeScreen extends ConsumerStatefulWidget {
  final Tig tig;

  const TigModeScreen({super.key, required this.tig});

  @override
  _TigModeScreenState createState() => _TigModeScreenState();
}

class _TigModeScreenState extends ConsumerState<TigModeScreen> {
  TimeEntry? _currentTimeEntry;
  late Tig _tig;
  Timer? _timer;
  late int _remainSeconds;
  late DateTime _startTime;
  late DateTime _endTime;
  bool _isWaiting = false;

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

  Widget _buildNoEntryWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cancel, color: Colors.red),
          const Text(
            '현재 시간에는 티그가 존재하지 않아요.\n티그를 등록하고 다시 시작해보세요😊',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          ElevatedButton(
            onPressed: () {
              _timer?.cancel();
              Navigator.pop(context);
            },
            child: const Text('나가기'),
          )
        ],
      ),
    );
  }

  Widget _buildEntryWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '시작 시간: ${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          '종료 시간: ${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          '${_currentTimeEntry?.activity}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          _isWaiting ? '대기 중' : '남은 시간',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          '${_remainSeconds ~/ 60}분 ${(_remainSeconds % 60).toString().padLeft(2, '0')}초',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                if (_currentTimeEntry != null) {
                  final tigUsecase = ref.read(tigUseCaseProvider);
                  final userId = await _getUserId();
                  _currentTimeEntry!.isSucceed = true;
                  await tigUsecase.saveTigData(userId, _tig);
                  _moveToNextEntry();
                }
              },
              child: const Text('다음 으로'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _timer?.cancel();
                Navigator.pop(context);
              },
              child: const Text('종료'),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> _getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('userId') ?? '';
  }
}
