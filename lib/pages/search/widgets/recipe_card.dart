import 'package:flutter/material.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:provider/provider.dart';
import 'package:hotbap/application/viewmodels/recipe_viewmodel.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        width: double.infinity,
        height: 160,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Container(
              width: 121,
              height: 144,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(8),
                image: recipe.imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(recipe.imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.ingredients,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w300,
                        height: 1.50,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      recipe.nutritionInfo,
                      style: TextStyle(
                        color: Color(0xFF7F7F7F),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void clearRecipes(BuildContext context) {
  Provider.of<RecipeViewModel>(context, listen: false).clearRecipes();
}
