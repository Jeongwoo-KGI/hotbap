import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotbap/domain/usecase/sign_in_with_apple_usecase.dart';

// LoginViewModel을 StateNotifier로 변경
class LoginViewModel extends StateNotifier<User?> {
  final SignInWithAppleUseCase _signInWithAppleUseCase;

  LoginViewModel(this._signInWithAppleUseCase) : super(null);

  Future<void> signInWithApple() async {
    try {
      final userCredential = await _signInWithAppleUseCase.execute();
      state = userCredential.user;
    } catch (e) {
      // 에러 처리 로직
      print("애플 로그인 중 오류 발생: $e");
    }
  }
}
