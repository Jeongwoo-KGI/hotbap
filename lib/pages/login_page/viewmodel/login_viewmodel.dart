import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotbap/domain/usecase/save_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

          if (userDoc.exists) {
            // Firestore에 해당 UID 문서가 없을 경우, 리버팟 상태로 UID 저장
            ref.read(authUidProvider.notifier).setUid(user.uid); // 리버팟 상태 업데이트
          }
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
}
