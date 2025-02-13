import 'package:hotbap/domain/entity/recipe.dart';

abstract class AiRecipeRepository {

  //레시피 저장
  Future<void> addRecipe(Recipe recipe);

  //레시피 삭제 
  Future<void> removeRecipe(Recipe recipe);

  //레시피 불러오기 
  Future<void> getRecipe(Recipe recipe);
}