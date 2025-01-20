import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                alignment: Alignment.center, // 중앙 정렬
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
                  mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                  children: [
                    // 상단 텍스트
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
                    const SizedBox(height: 14), // 여백 추가

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
                    Container(
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

                    // 직접 입력해서 로그인 텍스트
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
