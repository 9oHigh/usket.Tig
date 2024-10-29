import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/domain/repositories/auth_repository.dart';
import 'package:tig/data/models/user.dart';

class AuthDatasource implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final kakao.UserApi _kakaoSignIn = kakao.UserApi.instance;

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
      await _signInWithCredential(credential);
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
    await _signInWithCredential(authCredential);
  }

  @override
  Future<void> signInWithKakao() async {
    kakao.User? kakaoUser;
    try {
      if (await kakao.isKakaoTalkInstalled()) {
        await _kakaoSignIn.loginWithKakaoTalk();
      } else {
        await _kakaoSignIn.loginWithKakaoAccount();
      }
      kakaoUser = await _kakaoSignIn.me();
      await _signInWithKakaoUser(kakaoUser);
    } catch (error) {
      if (error is PlatformException && error.code == "CANCELED") {
        rethrow;
      }
      rethrow;
    }
  }

  Future<void> _signInWithKakaoUser(kakao.User kakaoUser) async {
    String email = "${kakaoUser.id}@kakao.com";
    String password = "${kakaoUser.id}";
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        rethrow;
      }
    }
    await _handleSignInResult();
  }

  Future<void> _signInWithCredential(AuthCredential credential) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    await _handleSignInResult(user: userCredential.user);
  }

  Future<void> _handleSignInResult({User? user}) async {
    user ??= _firebaseAuth.currentUser;
    if (user != null) {
      String storedUserId =
          SharedPreferenceManager().getPref<String>(PrefsType.userId) ?? "";
      if (user.uid != storedUserId) {
        await SharedPreferenceManager().setPref(PrefsType.userId, user.uid);
        await _registerUser(user);
      }
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
  Future<UserModel?> getUser() async {
    String uid =
        SharedPreferenceManager().getPref<String>(PrefsType.userId) ?? "";
    final userRef = _firestore.collection('users').doc(uid);
    final doc = await userRef.get();

    await userRef.update({'lastLogin': DateTime.now()});

    return doc.exists ? UserModel.fromMap(doc.data()!) : null;
  }

  @override
  Future<void> deleteUser() async {
    try {
      String uid =
          SharedPreferenceManager().getPref<String>(PrefsType.userId) ?? "";
      User? user = _firebaseAuth.currentUser;
      if (user != null && user.uid == uid) {
        await _firestore.collection('users').doc(uid).delete();
        await SharedPreferenceManager().removePref(PrefsType.userId);
        await user.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
