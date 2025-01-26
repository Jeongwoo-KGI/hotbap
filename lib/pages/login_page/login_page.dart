import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/pages/login_page/conditions_page.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/providers.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    // authStateProvider의 상태에 따라 위젯을 빌드
    return authState.when(
      data: (user) {
        if (user != null) {
          print('로그인페이지16 ${user.uid}');
          return FutureBuilder(
            // Firestore에서 사용자의 UID 존재 여부 확인
            future: _checkUserInFirestore(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Firestore 작업이 진행 중일 때 로딩 표시
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류 발생: ${snapshot.error}'));
              } else if (snapshot.data == true) {
                // Firestore에 UID가 존재하면 메인 페이지로 이동
                return MainPage();
              } else {
                // Firestore에 UID가 없으면 ConditionsPage로 이동
                return ConditionsPage();
              }
            },
          );
        } else {
          // 로그인 화면
          return LoginWidget();
        }
      },
      // 인증 상태 확인 중 로딩 표시
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('오류 발생: $err')),
    );
  }

  // Firestore에서 사용자의 UID가 존재하는지 확인하는 메서드
  Future<bool> _checkUserInFirestore(String uid) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('user').doc(uid).get();
    return userDoc.exists; // Firestore에 UID가 존재 여부 반환
  }
}

class LoginWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 로그인 로직을 처리하는 ViewModel 가져오기
    final loginViewModel = ref.read(loginViewModelProvider);

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
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Apple 로그인 버튼
                    GestureDetector(
                      onTap: () async {
                        try {
                          final uid = await loginViewModel.signInWithApple(
                            context,
                          );
                          if (uid != null) {
                            print("로그인 성공: UID -> $uid");
                          }
                        } catch (e) {
                          print("로그인 실패: $e");
                        }
                      },
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.apple, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Apple로 시작하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
