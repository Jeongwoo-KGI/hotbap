import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/pages/login_page/imsi_page.dart';

// Firebase 인증 상태를 제공하는 StreamProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return ImsiPage(); // 인증 성공 시 이동할 페이지
        } else {
          return LoginWidget(); // 로그인 화면
        }
      },
      loading: () => Center(child: CircularProgressIndicator()), // 로딩 화면
      error: (err, _) => Center(child: Text('오류 발생: $err')), // 에러 화면
    );
  }
}

// 로그인 화면
class LoginWidget extends StatelessWidget {
  Future<void> signInWithApple() async {
    try {
      // 생성된 nonce
      final rawNonce = _generateNonce();
      final hashedNonce = _hashNonce(rawNonce);

      // Apple 로그인 요청
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce, // Firebase와 동일한 nonce를 전달해야 함
      );

      // OAuthCredential 생성
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Firebase 로그인
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } catch (e) {
      debugPrint('Apple 로그인 실패: $e');
      rethrow;
    }
  }

  // 난수 생성
  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  // SHA-256 해시 생성
  String _hashNonce(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 상단 영역
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text(
                  'SmoothPageIndicator 자리',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // 하단 로그인 영역
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '3초 만에 빠른 로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 14),
                    // 구글로 시작하기 버튼
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 56,
                      margin: const EdgeInsets.only(bottom: 11),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Color(0xFFE6E6E6),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        '구글로 시작하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                      ),
                    ),
                    // Apple로 시작하기 버튼
                    GestureDetector(
                      onTap: signInWithApple,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: ShapeDecoration(
                          color: Color(0xFF333333),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Apple로 시작하기',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '직접 입력해서 로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4C4C4C),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
