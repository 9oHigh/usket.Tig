import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tig/data/models/tig.dart';

class UserModel {
  String uid;
  String nickname;
  bool isSubscribed;
  DateTime createdAt;
  DateTime? lastLogin;
  List<Tig> tigs;

  UserModel({
    required this.uid,
    required this.nickname,
    required this.isSubscribed,
    required this.createdAt,
    this.lastLogin,
    this.tigs = const [],
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      nickname: map['nickname'] as String,
      isSubscribed: map['isSubscribed'] as bool,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLogin: map['lastLogin'] != null
          ? (map['lastLogin'] as Timestamp).toDate()
          : null,
      tigs: (map['tigs'] as List<dynamic>?)
              ?.map((item) => Tig.fromMap(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'isSubscribed': isSubscribed,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
      'tigs': tigs.map((tig) => tig.toMap()).toList(),
    };
  }
}
