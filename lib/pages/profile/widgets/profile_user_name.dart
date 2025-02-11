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
              padding: EdgeInsets.only(
                  top: 0.0,
                  bottom: 0.0,
                  right: screenWidth * 0.013,
                  left: screenWidth * 0.026), // 위, 아래, 오른쪽 패딩 추가
              child: Text(
                userName,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: screenWidth * 0.085,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.all(0), // 모든 패딩 제거
              child: Text(
                userName == '로그인을 해주세요' ? '' : '님',
                style: TextStyle(
                  color: Color(0xFF999999), // '님' 텍스트 색상 설정
                  fontSize: screenWidth * 0.085,
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