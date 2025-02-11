import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 추가
import 'package:flutter_svg/flutter_svg.dart'; // flutter_svg 패키지 추가

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
        SizedBox(height: 10),
        Container(
          width: 375,
          height: 40,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '이용약관',
                style: TextStyle(
                  color: Color(0xFF4D4D4D),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 255),
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/svg/arrow_s_right.svg'),
                  onPressed: _launchURL, // 버튼을 눌렀을 때 URL을 열도록 설정
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0),
        Container(
          width: 375,
          height: 40,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'FAQ',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 275),
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/svg/arrow_s_right.svg'),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
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
