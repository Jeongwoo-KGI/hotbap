import 'package:flutter/material.dart';

class SavedRecipes extends StatelessWidget {
  final double screenWidth;
  final List<String> savedRecipes;

  SavedRecipes(this.screenWidth, this.savedRecipes);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '저장한 레시피',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: screenWidth * 0.04,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            height: 1.35,
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
