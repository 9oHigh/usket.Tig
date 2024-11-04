import 'package:equatable/equatable.dart';

class TagState extends Equatable {
  final List<String> tags;
  final String errorMessage;

  const TagState({
    this.tags = const [],
    this.errorMessage = "",
  });

  TagState copyWith({
    List<String>? tags,
    String? errorMessage,
  }) {
    return TagState(
      tags: tags ?? this.tags,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<String?> get props => [errorMessage];
}
