import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isAnimationCompleted;
  final bool isLoading;
  final String message;
  final bool isLoggedIn;

  const AuthState({
    this.isAnimationCompleted = false,
    this.isLoading = false,
    this.message = "",
    this.isLoggedIn = false,
  });

  const AuthState.initial({
    this.isAnimationCompleted = false,
    this.isLoading = false,
    this.message = "",
    this.isLoggedIn = false,
  });

  AuthState copyWith({
    bool? isAnimationCompleted,
    bool? isLoading,
    String? message,
    bool? isLoggedIn,
  }) {
    return AuthState(
      isAnimationCompleted: isAnimationCompleted ?? this.isAnimationCompleted,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [isAnimationCompleted, isLoading, message, isLoggedIn];
}
