import 'package:equatable/equatable.dart';
import 'package:tig/data/models/tig.dart';

class HomeState extends Equatable {
  final bool isDayExpanded;
  final bool isOnDaily;
  final bool isOnBraindump;
  final bool isAdLoading;
  final bool isTwelvetimeSystem;
  final String userId;
  final DateTime currentDateTime;
  final List<String> tags;
  final Tig? tig;

  const HomeState({
    this.isDayExpanded = true,
    this.isOnDaily = true,
    this.isOnBraindump = true,
    this.isAdLoading = false,
    this.isTwelvetimeSystem = false,
    this.userId = "",
    required this.currentDateTime,
    this.tags = const [],
    this.tig,
  });
  
  HomeState copyWith({
    bool? isDayExpanded,
    bool? isAtBottom,
    bool? isOnDaily,
    bool? isOnBraindump,
    bool? isAdLoading,
    bool? isTwelvetimeSystem,
    String? userId,
    DateTime? currentDateTime,
    List<String>? tags,
    Tig? tig,
  }) {
    return HomeState(
        isDayExpanded: isDayExpanded ?? this.isDayExpanded,
        isOnDaily: isOnDaily ?? this.isOnDaily,
        isOnBraindump: isOnBraindump ?? this.isOnBraindump,
        isAdLoading: isAdLoading ?? this.isAdLoading,
        isTwelvetimeSystem: isTwelvetimeSystem ?? this.isTwelvetimeSystem,
        userId: userId ?? this.userId,
        currentDateTime: currentDateTime ?? this.currentDateTime,
        tags: tags ?? this.tags,
        tig: tig ?? this.tig);
  }

  @override
  List<Object?> get props => [
        isDayExpanded,
        isOnDaily,
        isOnBraindump,
        isAdLoading,
        isTwelvetimeSystem,
        userId,
        currentDateTime,
        tags,
        tig
      ];
}
