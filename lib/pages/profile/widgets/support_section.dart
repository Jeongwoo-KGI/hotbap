import 'package:flutter/material.dart';
import 'list_item.dart';

class SupportSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  SupportSection(this.screenWidth, this.screenHeight);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '핫밥 정보 및 지원',
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
          ListItem(screenWidth, screenHeight, '이용약관', () {}),
          ListItem(screenWidth, screenHeight, 'FAQ', () {}),
        ],
      ),
    );
  }
}
