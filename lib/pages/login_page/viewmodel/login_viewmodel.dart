import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotbap/domain/usecase/save_user.dart';
import 'package:hotbap/providers.dart';

class LoginViewModel {
  final SaveUser saveUserUseCase;
  final ProviderRef ref;

  LoginViewModel({required this.saveUserUseCase, required this.ref});

  // Apple 로그인 처리
  Future<String?> signInWithApple(BuildContext context) async {
    try {
      final appleProvider = AppleAuthProvider();
      final userCredential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);

      final user = userCredential.user;
      if (user != null) {
        final firestore = FirebaseFirestore.instance;
        try {
          // Firestore에서 사용자 UID 문서 확인
          final userDoc =
              await firestore.collection('user').doc(user.uid).get();
        } catch (e) {
          print("Firestore 권한 오류 또는 기타 문제 발생: $e");
        }

        return user.uid; // UID 반환
      }
    } catch (e) {
      print("Apple 로그인 실패: $e");
    }
    return null;
  }

  // Google 로그인 처리
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // 사용자가 로그인 작업을 취소한 경우
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        final firestore = FirebaseFirestore.instance;
        try {
          // Firestore에서 사용자 UID 문서 확인
          final userDoc =
              await firestore.collection('user').doc(user.uid).get();
        } catch (e) {
          print("Firestore 권한 오류 또는 기타 문제 발생: $e");
        }

        return user.uid; // UID 반환
      }
    } catch (e) {
      print("Google 로그인 실패: $e");
    }
    return null;
  }
}