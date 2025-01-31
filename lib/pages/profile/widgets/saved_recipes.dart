import 'package:flutter/material.dart';

class SavedRecipes extends StatelessWidget {
  final double screenWidth;
  final List<String> savedRecipes;
  final VoidCallback navigateToSavedRecipes; // 찜리스트로 이동하는 함수

  SavedRecipes(this.screenWidth, this.savedRecipes, this.navigateToSavedRecipes);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onTap: navigateToSavedRecipes,
            child: Container(
              width: 330, // 너비 설정
              height: 60, // 높이 설정
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical:15),
              margin: const EdgeInsets.symmetric(vertical: 5), // 상하 여백 추가
              decoration: ShapeDecoration(
                color: Color(0xFFFCE3DD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '나의 찜',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                  SizedBox(width: 235), // 여백 추가
                  Text(
                    '${savedRecipes.length}', // 저장한 레시피 개수 표시
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}