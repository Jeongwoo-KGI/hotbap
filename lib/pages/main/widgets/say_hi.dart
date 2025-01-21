import 'package:flutter/material.dart';

class SayHi extends StatelessWidget{
  String userName;
  SayHi({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$userName 님 반갑습니다",
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontFamily: 'Pretendard',
      ),
    );
  }
}