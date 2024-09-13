import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tig/domain/repositories/auth_repository.dart';
import 'package:tig/data/models/user.dart';

class AuthDatasource implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        await _registerUser(user);
      }
    }
  }

  @override
  Future<void> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
    );

    final authCredential = OAuthProvider('apple.com').credential(
      accessToken: credential.authorizationCode,
      idToken: credential.identityToken,
    );

    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential);
    User? user = userCredential.user;
    if (user != null) {
      await _registerUser(user);
    }
  }
  Future<void> _registerUser(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);

    final userDoc = await userRef.get();
    if (!userDoc.exists) {
      UserModel userModel = UserModel(
        uid: user.uid,
        nickname: user.displayName ?? 'No Name',
        isSubscribed: false,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      await userRef.set(userModel.toMap());
    } else {
      await userRef.update({'lastLogin': DateTime.now()});
    }
  }

  @override
  Future<UserModel?> getUser(String uid) async {
    final userRef = _firestore.collection('users').doc(uid);
    final doc = await userRef.get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      return null;
    }
  }
}
