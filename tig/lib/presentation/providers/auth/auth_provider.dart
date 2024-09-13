import 'package:riverpod/riverpod.dart';
import 'package:tig/data/datasources/auth_datasource.dart';
import 'package:tig/data/repositories/auth_repository_impl.dart';
import 'package:tig/domain/repositories/auth_repository.dart';
import 'package:tig/domain/usecases/auth_usecase.dart';

final authDataSourceProvider = Provider<AuthDatasource>((ref) {
  return AuthDatasource();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseDataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(firebaseDataSource);
});

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthUseCase(authRepository);
});
