import 'package:flutter/material.dart';

class AccountManagement extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback logout;
  final VoidCallback deleteAccount;

  AccountManagement(
      this.screenWidth, this.screenHeight, this.logout, this.deleteAccount);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
          child: Text(
            '계정 관리',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: screenWidth * 0.04,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // 비율에 맞춘 간격
        GestureDetector(
          onTap: logout, // 로그아웃 기능 설정
          child: Container(
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
            child: Text(
              '로그아웃',
              style: TextStyle(
                color: Color(0xFFDD0909),
                fontSize: screenWidth * 0.035,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // 비율에 맞춘 간격
        GestureDetector(
          onTap: deleteAccount, // 회원 탈퇴 기능 설정
          child: Container(
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
            child: Text(
              '회원 탈퇴',
              style: TextStyle(
                color: Color(0xFF4D4D4D),
                fontSize: screenWidth * 0.035,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}