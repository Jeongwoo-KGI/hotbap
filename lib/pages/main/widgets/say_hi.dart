import 'package:flutter/material.dart';
class SayHi extends StatelessWidget{
  String userName;
  SayHi({required this.userName});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFF656565),
          fontWeight: FontWeight.w500,
          fontFamily: 'Pretendard',
          height: 1.35,
        ),
        children: <TextSpan> [
          TextSpan(
            text: "$userName",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w700,
              fontFamily: 'Pretendard',
              height: 1.35
            ),
          ),
          TextSpan(text: " 님 반갑습니다!"),
        ]
      ),
    );
  }
}
  

