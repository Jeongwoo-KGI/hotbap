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
          TextSpan(
            text: userName,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 32,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
          TextSpan(
            text: '님',
            style: TextStyle(
              color: Color(0xFF999999), // '님' 텍스트 색상 설정
              fontSize: 32,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}