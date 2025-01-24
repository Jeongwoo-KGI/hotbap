import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Firebase 인증 상태를 제공하는 StreamProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// ViewModel 클래스
class LoginViewModel {
  // Apple 로그인 처리
  Future<void> signInWithApple() async {
    final appleProvider = AppleAuthProvider();

    try {
      await FirebaseAuth.instance.signInWithProvider(appleProvider);
    } catch (e) {
      throw Exception('Apple 로그인 실패: $e');
    }
  }

  // 현재 로그인된 사용자 가져오기
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
