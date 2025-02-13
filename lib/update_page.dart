import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 전체 배경색

      body: Center(
        child: Container(
          width: 298,
          height: 175,
          padding: const EdgeInsets.only(
            top: 40,
            left: 24,
            right: 24,
            bottom: 26,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Text(
                '업데이트 후 이용이 가능합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 34),
              GestureDetector(
                onTap: () async {
                  final url =
                      "itms-apps://itunes.apple.com/kr/app/id6741564422"; //https://apps.apple.com/kr/app/id6741564422?l=en-GB
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
                child: Container(
                  width: 137,
                  height: 51,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                  decoration: ShapeDecoration(
                    color: Color(0xFFE33811),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    '업데이트 하러가기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
