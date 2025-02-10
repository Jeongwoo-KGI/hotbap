import 'package:flutter/material.dart';

class ProfileUserName extends StatelessWidget {
  final double screenWidth;
  final String userName;

  ProfileUserName(this.screenWidth, this.userName);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0.0,
                  bottom: 0.0,
                  right: 5.0,
                  left: 10), // 위, 아래, 오른쪽 패딩 추가
              child: Text(
                userName,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 32,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0.0,
                  bottom: 0.0,
                  right: 0.0,
                  left: 0.0), // 위, 아래, 오른쪽 패딩 추가
              child: Text(
                userName == '로그인을 해주세요' ? '' : '님',
                style: TextStyle(
                  color: Color(0xFF999999), // '님' 텍스트 색상 설정
                  fontSize: 32,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
