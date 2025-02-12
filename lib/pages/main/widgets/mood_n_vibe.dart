import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';
import 'package:hotbap/pages/main/widgets/individual_big.dart';

class MoodNVibe extends StatelessWidget{
  List<Recipe> resultRecipes;
  MoodNVibe({required this.resultRecipes});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
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
        SizedBox(height: 12,),
        Container(
          height: 260,
          padding: EdgeInsets.only(left: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
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