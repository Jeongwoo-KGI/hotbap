import 'package:flutter/material.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/pages/main/widgets/jechul_food_rec.dart';
import 'package:hotbap/pages/main/widgets/logo_and_filter.dart';
import 'package:hotbap/pages/main/widgets/mood_n_vibe.dart';
import 'package:hotbap/pages/main/widgets/recipe_result.dart';
import 'package:hotbap/theme.dart';

class GuestPageMain extends StatelessWidget{
  List<Recipe> resultRecipesAI;
  List<Recipe> resultRecipesMNV;
  List<Recipe> resultJechul;

  GuestPageMain({super.key, required this.resultRecipesAI, required this.resultRecipesMNV, required this.resultJechul});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //logo and filter button
            LogoAndFilter(),
            Padding(
              padding: EdgeInsets.only(left: 22, bottom: 12, top: 10),
            ),
            //Recipe Results
            RecipeResult(searchResult: resultRecipesAI),
            //Recipe Curated1: mood n vibe
            MoodNVibe(resultRecipes: resultRecipesMNV),
            //Recipe Jechul
            JechulFoodRec(resultRecipes: resultJechul,),
          ],
        ),
      ),
      bottomNavigationBar:
          BottomNavBar(initialIndex: 0), // 초기 인덱스를 설정하여 네비게이션 바 추가
      );
  }
}