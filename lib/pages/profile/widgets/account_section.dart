import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback saveUserName;

  AccountSection(this.screenWidth, this.screenHeight, this.saveUserName);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '내 계정',
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
                '닉네임 수정',
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
                  onPressed: saveUserName,
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