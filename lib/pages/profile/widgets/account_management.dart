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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '계정 관리',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '로그아웃',
                style: TextStyle(
                  color: Color(0xFFDD0909),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
              SizedBox(
                width: 9.5,
                height: 17.48,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF333333)),
                  onPressed: logout,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '회원 탈퇴',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
              SizedBox(
                width: 9.5,
                height: 17.48,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF333333)),
                  onPressed: deleteAccount,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}