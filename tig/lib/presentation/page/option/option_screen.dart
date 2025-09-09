import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/presentation/page/option/provider/option_notifier_provider.dart';
import 'package:tig/presentation/page/option/provider/state/option_notifier.dart';
import 'package:tig/presentation/page/option/provider/state/option_state.dart';

enum OptionType { isOnDaily, isOnBraindump }

class OptionScreen extends ConsumerStatefulWidget {
  const OptionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OptionScreen();
}

class _OptionScreen extends ConsumerState<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    final OptionState optionState = ref.watch(optionNotifierProvider);
    final OptionNotifier optionNotifier =
        ref.read(optionNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('home_arrange_title')),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Daily Priority',
                    style: Theme.of(context).textTheme.bodyLarge),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Switch(
                        value: optionState.isOnDaily,
                        onChanged: (value) async {
                          await optionNotifier.changeDailyOption(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Braindump', style: Theme.of(context).textTheme.bodyLarge),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Switch(
                        value: optionState.isOnBraindump,
                        onChanged: (value) async {
                          await optionNotifier.changeBraindumpOption(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Time System',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SegmentedButton<TimeSystem>(
                          style: const ButtonStyle(
                            visualDensity: VisualDensity.compact,
                          ),
                          segments: const [
                            ButtonSegment(
                              value: TimeSystem.twelve,
                              label: Text('12H'),
                            ),
                            ButtonSegment(
                              value: TimeSystem.twentyFour,
                              label: Text('24H'),
                            ),
                          ],
                          selected: {optionState.timeSystem},
                          onSelectionChanged: (Set<TimeSystem> selected) {
                            final selectedTimeSystem = selected.first;
                            optionNotifier.updateTimeSystem(selectedTimeSystem);
                          },
                          showSelectedIcon: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                optionState.timeSystem == TimeSystem.twentyFour
                    ? Expanded(
                        child: Text(
                          textAlign: TextAlign.end,
                          Intl.message("option_explain_twentyFour"),
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 118, 118, 118)),
                        ),
                      )
                    : Expanded(
                        child: Text(
                          textAlign: TextAlign.end,
                          Intl.message("option_explain_twelve"),
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 118, 118, 118)),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
