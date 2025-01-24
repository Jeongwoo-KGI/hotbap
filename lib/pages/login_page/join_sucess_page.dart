import 'package:flutter/material.dart';
import 'package:hotbap/pages/main/main_page.dart';

class JoinSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                'HOT밥에\n오신 걸 환영해요!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              Spacer(),
              Container(
                child: Text('로고자리'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  // 페이지 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                child: Text('완료'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                  backgroundColor: Color(0xFFE33811), // 버튼 배경색
                  foregroundColor: Colors.white, // 텍스트 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // 버튼의 모서리 둥글게
                  ),
                ),
              ),
              SizedBox(height: 9),
            ],
          ),
        ),
      ),
    );
  }
}
