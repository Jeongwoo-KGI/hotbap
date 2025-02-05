import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotbap/pages/login_page/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    // 로고가 서서히 나타남
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _visible = false;
      });
    });

    // 스플래시 화면 이후 일정 시간 후에 로그인 페이지로 이동
    Future.delayed(Duration(seconds: 4), () {
      // 애니메이션이 끝난 후에 페이지 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      backgroundColor: Color(0xFFE33811),
      body: SafeArea(
        child: AnimatedOpacity(
          opacity: _visible ? 0.0 : 1.0, // 서서히 나타남
          duration: Duration(seconds: 1), // 1초 동안 나타나고 사라짐
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/logo_splash.svg', // SVG 이미지 경로
                  width: 164.3,
                  height: 198,
                ),
              ),
              SizedBox(height: 39),
              SizedBox(
                width: 153,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '따뜻한 식사를 위한',
                        style: TextStyle(
                          color: Color(0xFFFEF2E6),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          height: 1.1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: 153,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '나만의 ',
                        style: TextStyle(
                          color: Color(0xFFFEF2E6),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          height: 1.1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '레시피 추천',
                        style: TextStyle(
                          color: Color(0xFFFEF2E6),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          height: 1.1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: ' 리스트',
                        style: TextStyle(
                          color: Color(0xFFFEF2E6),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          height: 1.1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
