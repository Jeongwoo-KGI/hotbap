import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 추가

class SupportSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  SupportSection(this.screenWidth, this.screenHeight);

  final String termsUrl = 'https://tutle02.tistory.com/60';

  void _launchURL() async {
    if (await canLaunch(termsUrl)) {
      await launch(termsUrl);
    } else {
      throw 'Could not launch $termsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  onPressed: _launchURL, // 버튼을 눌렀을 때 URL을 열도록 설정
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
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