import 'package:tig/data/models/user.dart';

abstract class AuthRepository {
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<UserModel?> getUser(String uid);
}
