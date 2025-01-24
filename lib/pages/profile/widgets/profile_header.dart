import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  ProfileHeader(this.screenWidth, this.screenHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.95,
      height: screenHeight * 0.1,
      padding: const EdgeInsets.all(10),
      child: Text(
        '마이페이지',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.05,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          height: 1.35,
        ),
      ),
    );
  }
}
