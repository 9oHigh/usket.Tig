import 'package:equatable/equatable.dart';

enum TimeSystem {
  twentyFour,
  twelve,
}

class OptionState extends Equatable {
  final bool isOnDaily;
  final bool isOnBraindump;
  final TimeSystem timeSystem;

  const OptionState({
    this.isOnDaily = false,
    this.isOnBraindump = false,
    this.timeSystem = TimeSystem.twentyFour,
  });

  OptionState copyWith({
    bool? isOnDaily,
    bool? isOnBraindump,
    TimeSystem? timeSystem,
  }) {
    return OptionState(
      isOnDaily: isOnDaily ?? this.isOnDaily,
      isOnBraindump: isOnBraindump ?? this.isOnBraindump,
      timeSystem: timeSystem ?? this.timeSystem,
    );
  }

  @override
  List<Object?> get props => [isOnDaily, isOnBraindump, timeSystem];
}
