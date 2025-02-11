import 'package:flutter/material.dart';
import 'package:hotbap/pages/profile/widgets/guest_dialog.dart';

class SavedRecipes extends StatelessWidget {
  final double screenWidth;
  final List<String> savedRecipes;
  final VoidCallback navigateToSavedRecipes; // 찜리스트로 이동하는 함수

  SavedRecipes(
      this.screenWidth, this.savedRecipes, this.navigateToSavedRecipes);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              if (savedRecipes.isEmpty) {
                showNoSavedRecipesDialog(context);
              } else {
                navigateToSavedRecipes();
              }
            },
            child: Container(
              width: screenWidth * 0.9, // 너비를 화면 너비의 90%로 설정
              height: screenWidth * 0.15, // 높이를 화면 너비의 15%로 설정
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              margin: EdgeInsets.symmetric(vertical: screenWidth * 0.012), // 상하 여백을 화면 너비의 1.2%로 설정
              decoration: ShapeDecoration(
                color: Color(0xFFFCE3DD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.035),
                  side: BorderSide(
                    width: screenWidth * 0.005,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFFFACFC6),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이템 사이에 여백을 추가하여 좌우 아이템을 배치
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '나의 찜',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: screenWidth * 0.035,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    '${savedRecipes.isEmpty ? 0 : savedRecipes.length}', // 게스트 모드는 0, 회원 모드는 실제 개수
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: screenWidth * 0.035,
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