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
  Future<UserModel?> getUser(String uid) => _authDataSource.getUser(uid);
}
