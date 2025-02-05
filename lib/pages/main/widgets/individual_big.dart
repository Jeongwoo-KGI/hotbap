import 'package:flutter/material.dart';
import 'package:hotbap/domain/entity/recipe.dart';

Widget individualBigRecipe (Recipe recipe){ 
  String carbs = recipe.carbohydrate;
  String fat = recipe.fat;
  String protein = recipe.protein;
  String input = recipe.title;
  String imageURL = recipe.imageUrl;
  String explanationText = recipe.manuals[0];
  return Row(
    children: [
      //SizedBox(width: 10),
      Container(
        width: 247,
        height: 260,
        padding: const EdgeInsets.only(top: 10, left: 12, right: 12, bottom: 12),
        decoration: ShapeDecoration(
          color: Color(0xFFF7F7F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              width: 223,
              height: 136,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("$imageURL"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 12,),
            //name
            SizedBox(
              width: double.infinity,
              child: Text(
                "$input", 
                style: TextStyle(
                  fontSize: 16, 
                  fontFamily: 'Pretendard', 
                  fontWeight: FontWeight.w600, 
                  color: Color(0xFF333333),
                ),
              ),
            ),
            SizedBox(height: 5,),
            //Nutrition ratio
            Text(
              "탄 ${carbs}g 단 ${protein}g 지 ${fat}g", 
              style: TextStyle(
                fontSize: 14, 
                fontFamily: 'Pretendard', 
                fontWeight: FontWeight.w400, 
                height: 1.50, 
                color: Color(0xFF999999),
              ),
            ),
            SizedBox(height: 5,),
            //Explanation
            SizedBox(
              width: 219,
              child: Text(
                "$explanationText",
                style: TextStyle(
                  color: Color(0xFFB3B3B3),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      SizedBox(width: 14,),
    ],
  );
}