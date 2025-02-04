import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';
import 'package:hotbap/pages/main/widgets/individual_big.dart';

class MoodNVibe extends ConsumerStatefulWidget{
  
  @override
  _MoodNVibeState createState() => _MoodNVibeState();
}

class _MoodNVibeState extends ConsumerState<MoodNVibe> {
  List<Recipe> resultRecipes = [];
  bool _isLoading = true;

  void initState() {
    super.initState();
    moodvibeRecipe();
  }

  Future<void> moodvibeRecipe() async {
    List<String> query = ["파스타", "스테이크", "와인", "연인"];
    List<String> substituteQuery = ['고기', '조기', '파인애플'];
    List<Recipe> recipes = [];
    final repository = ref.read(recipeRepositoryProvider);
    for(int i = 0;i<query.length;i++){
      recipes += await repository.getRecipesBasedOnGemini(query[i]);
    }
    if (recipes.length == 0) {
      for(int i = 0; i<substituteQuery.length; i++) {
        recipes += await repository.getJechulRecipeWithoutGemini(substituteQuery[i]);
      } 
    }
    setState(() {
      resultRecipes = recipes;
      _isLoading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    if(_isLoading) {
      return Center(child: CircularProgressIndicator(),);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20, bottom: 12),
          child: Text(
            "집에서 분위기 있게",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
        ),
        Container(
          height: 256,
          child: ListView.builder(
            itemCount: resultRecipes.length,
            itemBuilder: (context, index){
              final recipe = resultRecipes[index];
              final input = recipe;
              return GestureDetector(
                child: individualBigRecipe(input),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(recipe: input),
                    ),
                  );
                },
              );
            },
          )
        ),
      ],
    );
    
  }
}