import 'package:equatable/equatable.dart';

class OptionState extends Equatable {
  final bool isOnDaily;
  final bool isOnBraindump;

  const OptionState({
    this.isOnDaily = false,
    this.isOnBraindump = false,
  });

  OptionState copyWith({
    bool? isOnDaily,
    bool? isOnBraindump,
  }) {
    return OptionState(
        isOnDaily: isOnDaily ?? this.isOnDaily,
        isOnBraindump: isOnBraindump ?? this.isOnBraindump);
  }

  @override
  List<Object?> get props => [isOnDaily, isOnBraindump];
}
