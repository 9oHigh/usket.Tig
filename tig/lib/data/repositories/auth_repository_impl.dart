import 'package:tig/data/datasources/auth_datasource.dart';
import 'package:tig/data/models/user.dart';
import 'package:tig/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<void> signInWithGoogle() => _authDataSource.signInWithGoogle();

  @override
  Future<void> signInWithApple() => _authDataSource.signInWithApple();

  @override
  Future<void> signInWithKakao() => _authDataSource.signInWithKakao();

  @override
  Future<UserModel?> getUser() => _authDataSource.getUser();

  @override
  Future<void> deleteUser() => _authDataSource.deleteUser();
}
