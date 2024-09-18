import 'package:tig/data/models/tig.dart';
import 'package:tig/domain/repositories/tig_repository.dart';

class TigUsecase {
  final TigRepository repository;

  TigUsecase(this.repository);

  Future<Tig?> getTigData(String userId, DateTime date) async {
    return await repository.getTigData(userId, date);
  }

  Future<List<Tig>> getTigsForMonth(String userId, int year, int month) async {
    return await repository.getTigsForMonth(userId, year, month);
  }

  Future<void> saveTigData(String userId, Tig tig) async {
    await repository.saveTigData(userId, tig);
  }
}
