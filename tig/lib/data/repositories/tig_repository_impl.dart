import 'package:tig/data/datasources/tig_datasource.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/domain/repositories/tig_repository.dart';

class TigRepositoryImpl implements TigRepository {
  final TigDatasource _tigDataSource;

  TigRepositoryImpl(this._tigDataSource);

  @override
  Future<Tig?> getTigData(String userId, DateTime date) async =>
      await _tigDataSource.getTigData(userId, date);

  @override
  Future<void> saveTigData(String userId, Tig tig) async =>
      await _tigDataSource.saveTigData(userId, tig);

  @override
  Future<List<Tig>> getTigsForMonth(String userId, int year, int month) async =>
      await _tigDataSource.getTigsForMonth(userId, year, month);
}
