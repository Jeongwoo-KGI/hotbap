import 'package:flutter/material.dart';

class SupportSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  SupportSection(this.screenWidth, this.screenHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '핫밥 정보 및 지원',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: screenWidth * 0.04,
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
                '이용약관',
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
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20), // 간격 추가
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FAQ',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
              SizedBox(
                width: 9.5, // 아이콘 너비 설정
                height: 17.48, // 아이콘 높이 설정
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF333333)),
                  onPressed: () {},
                  padding: EdgeInsets.zero, // 패딩 제거
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