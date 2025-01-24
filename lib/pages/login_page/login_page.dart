import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/pages/login_page/conditions_page.dart';
import 'package:hotbap/pages/login_page/viewmodel/login_viewmodel.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState =
        ref.watch(authStateProvider); // authStateProvider를 뷰모델에서 가져옴
    final loginViewModel = LoginViewModel(); // LoginViewModel 인스턴스 생성

    return authState.when(
      data: (user) {
        if (user != null) {
          // 로그인된 사용자 정보 콘솔에 출력
          print('로그인된 사용자 정보:');
          print('UID: ${user.uid}');
          print('이메일: ${user.email}');
          return ConditionsPage(); // 인증 성공 시 이동할 페이지
        } else {
          return LoginWidget(viewModel: loginViewModel); // 로그인 화면
        }
      },
      loading: () => Center(child: CircularProgressIndicator()), // 로딩 화면
      error: (err, _) => Center(child: Text('오류 발생: $err')), // 에러 화면
    );
  }
}

// 로그인 화면 (현재 작성된 UI와 연결)
class LoginWidget extends StatelessWidget {
  final LoginViewModel viewModel;

  LoginWidget({required this.viewModel});

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

                    // Apple로 시작하기 버튼
                    GestureDetector(
                      onTap: () async {
                        try {
                          await viewModel.signInWithApple();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ConditionsPage(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
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
                            Icon(
                              Icons.apple,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Apple로 시작하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
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
            ),
          ],
        ),
      ),
    );
  }
}
