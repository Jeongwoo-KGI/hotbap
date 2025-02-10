import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/pages/login_page/conditions_page.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/providers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    // Firebase 인증 상태에 따라 위젯을 빌드
    return authState.when(
      data: (user) {
        if (user != null) {
          // 사용자 인증된 경우
          return FutureBuilder(
            future: _checkUserInFirestore(user.uid, ref),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류 발생: ${snapshot.error}'));
              } else if (snapshot.data == true) {
                // Firestore에 UID가 존재하면 MainPage로 이동
                return MainPage();
              } else {
                // Firestore에 UID가 없으면 ConditionsPage로 이동
                return ConditionsPage();
              }
            },
          );
        } else {
          // 사용자 인증 안 된 경우 로그인 화면 표시
          return LoginWidget();
        }
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('오류 발생: $err')),
    );
  }

  // Firestore에서 UID 존재 여부 확인
  Future<bool> _checkUserInFirestore(String uid, WidgetRef ref) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('user').doc(uid).get();

    return userDoc.exists;
  }
}

class LoginWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 로그인 로직을 처리하는 ViewModel 가져오기
    final loginViewModel = ref.read(loginViewModelProvider);
    final PageController _controller = PageController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 영역
            Container(
              width: double.infinity,
              color: Color(0xFFF7F7F7),
              child: Column(
                children: [
                  SizedBox(height: 32),
                  SmoothPageIndicator(
                    controller: _controller, // PageView의 컨트롤러
                    count: 3, // 페이지 개수
                    effect: WormEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      activeDotColor: Color(0xFFE33811),
                      dotColor: Color(0xFFCCCCCC), // 비활성화된 도트 색상
                    ), // 원하는 효과 지정
                  ),
                  SizedBox(height: 21),
                ],
              ),
            ),

            Container(
              height: 464,
              width: double.infinity,
              color: Colors.grey,
              alignment: Alignment.center,
              child: PageView(
                controller: _controller,
                children: [
                  Container(
                    color: Color(0xFFF7F7F7),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 375,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '당장 뭐 먹을지 고민이라면\n',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                  ),
                                ),
                                TextSpan(
                                  text: 'AI 추천 리스트',
                                  style: TextStyle(
                                    color: Color(0xFFE33811),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 1.35,
                                  ),
                                ),
                                TextSpan(
                                  text: '로 편리하게!',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/login_image_01.png',
                          width: 228, // 가로 크기
                          height: 383, // 세로 크기
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFF7F7F7),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 375,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '필터기능으로 ',
                                  style: TextStyle(
                                    color: Color(0xFFE33811),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                  ),
                                ),
                                TextSpan(
                                  text: '내가 원하는\n',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 1.35,
                                  ),
                                ),
                                TextSpan(
                                  text: '레시피를 쉽게 찾을 수 있어요!',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/login_image_02.png',
                          width: 228, // 가로 크기
                          height: 383, // 세로 크기
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFF7F7F7),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 375,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '원하는 재료나 레시피 이름 그리고\n',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                  ),
                                ),
                                TextSpan(
                                  text: '키워드로 ',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                  ),
                                ),
                                TextSpan(
                                  text: '쉽게 검색',
                                  style: TextStyle(
                                    color: Color(0xFFE33811),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 1.35,
                                  ),
                                ),
                                TextSpan(
                                  text: '해보세요!',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/login_image_03.png',
                          width: 228, // 가로 크기
                          height: 383, // 세로 크기
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 하단 로그인 영역
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      '3초 만에 빠른 로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
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
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      },
                      child: Text(
                        '건너뛰기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF656565),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.35,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26,
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
