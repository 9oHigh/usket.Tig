import 'package:riverpod/riverpod.dart';
import 'package:tig/data/datasources/tig_datasource.dart';
import 'package:tig/data/repositories/tig_repository_impl.dart';
import 'package:tig/domain/repositories/tig_repository.dart';
import 'package:tig/domain/usecases/tig_usecase.dart';

final tigDataSourceProvider = Provider<TigDatasource>((ref) {
  return TigDatasource();
});

final tigRepositoryProvider = Provider<TigRepository>((ref) {
  final tigDataSource = ref.watch(tigDataSourceProvider);
  return TigRepositoryImpl(tigDataSource);
});

final tigUseCaseProvider = Provider<TigUsecase>((ref) {
  final tigRepository = ref.watch(tigRepositoryProvider);
  return TigUsecase(tigRepository);
});
