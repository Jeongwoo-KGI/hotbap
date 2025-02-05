import 'package:flutter/material.dart';
import 'package:hotbap/domain/entity/recipe.dart';

Widget individualSmallRecipe (Recipe recipe){ 
  String carbs = recipe.carbohydrate;
  String fat = recipe.fat;
  String protein = recipe.protein;
  String input = recipe.title;
  String imageURL = recipe.imageUrl;
  return Row(
    children: [
      //SizedBox(width: 3),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              width: 121,
              height: 118,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("$imageURL"),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 8,),
            //name
            Text("$input", style: TextStyle(fontSize: 14, fontFamily: 'Pretendard', fontWeight: FontWeight.w600, color: Color(0xFF333333)),),
            //ratio
            Text("탄 ${carbs}g 단 ${protein}g 지 ${fat}g", style: TextStyle(fontSize: 10, fontFamily: 'Pretendard', fontWeight: FontWeight.w400, height: 1.50, color: Color(0xFF7F7F7F)),),
          ],
        ),
      ),
      SizedBox(width: 7,),
    ],
  );
}