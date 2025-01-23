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
    return ListTile(
      title: Text(
        '계정 관리',
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
          ListItem(screenWidth, screenHeight, '로그아웃', logout),
          ListItem(screenWidth, screenHeight, '회원 탈퇴', deleteAccount),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String text;
  final VoidCallback onPressed;

  ListItem(this.screenWidth, this.screenHeight, this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.95,
      height: screenHeight * 0.05,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                color: text == '로그아웃' || text == '회원 탈퇴'
                    ? Color(0xFFDD0909)
                    : Color(0xFF333333),
                fontSize: screenWidth * 0.035,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 1.30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
