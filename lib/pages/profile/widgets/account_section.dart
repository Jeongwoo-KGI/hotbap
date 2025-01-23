import 'package:flutter/material.dart';
import 'list_item.dart';

class AccountSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback saveUserName;

  AccountSection(this.screenWidth, this.screenHeight, this.saveUserName);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '내 계정',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF333333),
          fontSize: screenWidth * 0.04,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w700,
          height: 1.35,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListItem(screenWidth, screenHeight, '닉네임 수정', saveUserName),
          ListItem(screenWidth, screenHeight, '비밀번호 변경', () {}),
        ],
      ),
    );
  }
}
