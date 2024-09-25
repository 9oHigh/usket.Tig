import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tig/data/models/tig.dart';

class TigDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Tig?> getTigData(String userId, DateTime date) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        final userData = userDoc.data()!;
        if (userData.containsKey('tigs')) {
          final List<dynamic> tigsData = userData['tigs'];

          final Tig matchedTig =
              tigsData.map((tigData) => Tig.fromMap(tigData)).firstWhere(
                    (tig) =>
                        tig.date.year == date.year &&
                        tig.date.month == date.month &&
                        tig.date.day == date.day,
                  );
          return matchedTig;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Tig>> getTigsForMonth(String userId, int year, int month) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        final userData = userDoc.data()!;
        if (userData.containsKey('tigs')) {
          final List<dynamic> tigsData = userData['tigs'];
          final List<Tig> matchedTigs = tigsData
              .map((tigData) => Tig.fromMap(tigData))
              .where((tig) => tig.date.year == year && tig.date.month == month)
              .toList();
         
          return matchedTigs;
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> saveTigData(String userId, Tig tig) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        final userData = userDoc.data()!;
        List<dynamic> tigsData = userData['tigs'] ?? [];

        final existingTigIndex = tigsData.indexWhere((existingTigData) {
          final existingTig = Tig.fromMap(existingTigData);
          return existingTig.date.year == tig.date.year &&
              existingTig.date.month == tig.date.month &&
              existingTig.date.day == tig.date.day;
        });

        tig.grade = _getGrade(tig);

        if (existingTigIndex != -1) {
          tigsData[existingTigIndex] = tig.toMap();
        } else {
          tigsData.add(tig.toMap());
        }

        await _firestore.collection('users').doc(userId).update({
          'tigs': tigsData,
        });
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  int _getGrade(Tig tig) {
    int successCount = tig.timeTable.where((time) => time.isSucceed).length;

    if (successCount == 0) return 0;
    if (successCount < 6) return 1;
    if (successCount < 11) return 2;
    if (successCount < 16) return 3;
    return 4;
  }
}
