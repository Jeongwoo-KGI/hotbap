import 'package:flutter/material.dart';

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
                color: text == '로그아웃' ? Color(0xFFDD0909) : Color(0xFF333333),
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
