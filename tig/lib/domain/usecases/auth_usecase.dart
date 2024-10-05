import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<void> signInWithGoogle() async {
    await repository.signInWithGoogle();
  }

  Future<void> signInWithApple() async {
    await repository.signInWithApple();
  }

  Future<void> signInWithKakao() async {
    await repository.signInWithKakao();
  }
}
