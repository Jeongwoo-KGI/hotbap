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
          color: Colors.black,
          //fontWeight: FontWeight.w500,
          fontFamily: 'Pretendard',
        ),
        children: <TextSpan> [
          TextSpan(
            text: "$userName",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Pretendard',
            ),
          ),
          TextSpan(text: " 님 반갑습니다!"),
        ]
      ),
    );
  }
}