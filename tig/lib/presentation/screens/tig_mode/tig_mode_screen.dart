import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/screens/tig_mode/provider/tig_mode_notifier_provider.dart';
import 'package:tig/presentation/widgets/styles/circular_count_down_painter.dart';

class TigModeScreen extends ConsumerStatefulWidget {
  const TigModeScreen({super.key, required this.tig});
  final Tig tig;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TigModeScreenState();
}

class _TigModeScreenState extends ConsumerState<TigModeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tigModeNotifier = ref.read(tigModeNotifierProvider.notifier);
      tigModeNotifier.initialize(widget.tig);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tigModeState = ref.watch(tigModeNotifierProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return tigModeState.tig == null
        ? CircularProgressIndicator(
            color: isDarkMode ? Colors.white : Colors.black)
        : Scaffold(
            body: Center(
              child: tigModeState.timeEntry == null
                  ? _buildNoEntryWidget()
                  : _buildEntryWidget(),
            ),
          );
  }

  Widget _buildNoEntryWidget() {
    final tigModeNotifier = ref.read(tigModeNotifierProvider.notifier);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            Intl.message('tig_mode_empty_tig'),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(Intl.message('exit')),
          )
        ],
      ),
    );
  }

  Widget _buildEntryWidget() {
    final tigModeState = ref.watch(tigModeNotifierProvider);
    final tigModeNotifier = ref.read(tigModeNotifierProvider.notifier);
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
                  "${tigModeState.startTime.hour.toString().padLeft(2, '0')}:${tigModeState.startTime.minute.toString().padLeft(2, '0')}"
                ]),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                Intl.message('tig_mode_end_time', args: [
                  "${tigModeState.endTime.hour.toString().padLeft(2, '0')}:${tigModeState.endTime.minute.toString().padLeft(2, '0')}"
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
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Text(
                '${tigModeState.timeEntry?.activity}',
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
                  tigModeState.remainSeconds / (30 * 60), isDarkMode),
            ),
            Column(
              children: [
                Text(
                    tigModeState.isWaiting
                        ? Intl.message('tig_mode_waiting')
                        : Intl.message('tig_mode_remain_time'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(
                  Intl.message('tig_mode_count_down', args: [
                    ((tigModeState.remainSeconds ~/ 60).toString()),
                    ((tigModeState.remainSeconds % 60)
                        .toString()
                        .padLeft(2, '0'))
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
                Navigator.pop(context);
              },
              child: Text(Intl.message('end')),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () async {
                await tigModeNotifier.saveTigData();
              },
              child: Text(Intl.message('next')),
            ),
          ],
        ),
      ],
    );
  }
}
