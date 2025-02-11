import 'package:flutter/material.dart';

// 저장된 레시피가 없을 때 알림 팝업 띄우기
void showNoSavedRecipesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(0xFFFFFFFF), // 배경 색상 지정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 모서리 둥글게
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, // 다이얼로그 너비 조정
          height: MediaQuery.of(context).size.height * 0.25, // 다이얼로그 높이 조정
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '로그인 후 이용이 가능합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04), // 간격 추가
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 팝업 닫기
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white, // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              color: Color(0xFFE33811),
                              width: 1), // 테두리 색상과 두께 지정
                        ),
                      ),
                      child: Text(
                        '취소',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFE33811),
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 팝업 닫기
                        Navigator.pushReplacementNamed(
                            context, '/login'); // 로그인 페이지 이동
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFE33811), // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        '로그인 하러가기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}