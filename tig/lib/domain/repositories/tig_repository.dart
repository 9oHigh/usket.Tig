import '../../data/models/tig.dart';

abstract class TigRepository {
  Future<Tig?> getTigData(String userId, DateTime date);
  Future<void> saveTigData(String userId, Tig tig);
}