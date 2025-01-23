import 'package:flutter/material.dart';

class SavedRecipes extends StatelessWidget {
  final double screenWidth;
  final List<String> savedRecipes;
  final VoidCallback navigateToSavedRecipes;

  SavedRecipes(this.screenWidth, this.savedRecipes, this.navigateToSavedRecipes);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: navigateToSavedRecipes,
          child: Container(
            width: 336,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
            decoration: ShapeDecoration(
              color: Color(0xFFFCE3DD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
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
                Spacer(),
                Icon(
                  Icons.favorite_border,
                  color: Color(0xFF333333),
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