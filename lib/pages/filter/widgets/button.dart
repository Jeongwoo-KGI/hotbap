import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String content;
  final double height; // 높이 속성 추가
  final Function onPressed; // 버튼 액션 함수 추가

  Button({required this.content, this.height = 50.0, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 1,
          color: Color(0xFFE6E6E6),
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: Colors.white, // 기본 버튼 색상
      ),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          height: 1.50,
          color: Color(0xFF333333),
        ),
      ),
    );
  }
}