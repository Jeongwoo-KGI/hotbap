import 'package:flutter/material.dart';

class ProfileUserName extends StatelessWidget {
  final double screenWidth;
  final String userName;

  ProfileUserName(this.screenWidth, this.userName);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$userName님',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: screenWidth * 0.08,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
    );
  }
}
