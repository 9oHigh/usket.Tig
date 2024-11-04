import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tig/presentation/screens/option/provider/option_notifier_provider.dart';
import 'package:tig/presentation/screens/option/provider/state/option_notifier.dart';
import 'package:tig/presentation/screens/option/provider/state/option_state.dart';

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  Text('Braindump',
                      style: Theme.of(context).textTheme.bodyLarge),
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
            ],
          ),
        ),
      ),
    );
  }
}
