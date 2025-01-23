import '../entity/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipesBasedOnGemini(String query);
}
