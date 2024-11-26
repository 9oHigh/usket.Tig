import 'package:get_it/get_it.dart';
import 'package:tig/data/datasources/auth_datasource.dart';
import 'package:tig/data/datasources/tig_datasource.dart';
import 'package:tig/data/repositories/auth_repository_impl.dart';
import 'package:tig/data/repositories/tig_repository_impl.dart';
import 'package:tig/domain/repositories/auth_repository.dart';
import 'package:tig/domain/repositories/tig_repository.dart';
import 'package:tig/domain/usecases/auth_usecase.dart';
import 'package:tig/domain/usecases/tig_usecase.dart';

final injector = GetIt.instance;

void provideDataSources() {
  injector.registerFactory<TigDatasource>(() => TigDatasource());
  injector.registerFactory<AuthDatasource>(() => AuthDatasource());
}

void provideRepositories() {
  injector.registerFactory<TigRepository>(
      () => TigRepositoryImpl(injector.get<TigDatasource>()));
  injector.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(injector.get<AuthDatasource>()));
}

void provideUseCases() {
  injector.registerFactory<TigUsecase>(
    () => TigUsecase(injector.get<TigRepository>())
  );
  injector.registerFactory<AuthUseCase>(
      () => AuthUseCase(injector.get<AuthRepository>()));
}
