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
        GestureDetector(
          onTap: navigateToSavedRecipes,
          child: Container(
            width: 335,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
            decoration: ShapeDecoration(
              color: Color(0xFFFCE3DD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 14),
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
                Spacer(), // 빈 공간 추가
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
        for (String recipe in savedRecipes)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(recipe),
          ),
      ],
    );
  }
}