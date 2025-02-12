import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/repository/ai_stack_repository.dart';

class AiStackRepositoryImpl implements AiStackRepository{
  final FirebaseFirestore firebaseFirestore;

  AiStackRepositoryImpl({required this.firebaseFirestore});
  //save recipe
  @override
  Future<void> addRecipe(Recipe recipe) async {
    final docRef = firebaseFirestore
    .collection('Suggestion')
    .doc('fetchedData')
    .collection('jechul')
    .doc(recipe.title);
    //check if the menu elready exists
    final recipeData = await docRef.get();
    if (recipeData.exists) {
      return ;
    } else {
      await docRef.set({
        'title': recipe.title,
        'nutritionInfo': recipe.nutritionInfo,
        'imageUrl': recipe.imageUrl,
        'ingredients': recipe.ingredients,
        'material': recipe.material,
        'category': recipe.category,
        'calorie': recipe.calorie,
        'carbohydrate': recipe.carbohydrate,
        'protein': recipe.protein,
        'fat': recipe.fat,
        'sodium': recipe.sodium,
        'manuals': recipe.manuals,
        'lowSodiumTip': recipe.lowSodiumTip,
      });
    }
  }
  //get recipe
  @override
  Future<Recipe?> getRecipe (String recipeTitle) async {
    final docRef = firebaseFirestore
    .collection('Suggestion')
    .doc('fetchedData')
    .collection('jechul')
    .doc(recipeTitle);

    final recipeData = await docRef.get();
    
    if (recipeData.exists) {
      final recipe = Recipe.fromMap(recipeData.data()!);
      return recipe;
    } else {
      return null;
    }
  }
  //delete recipe
  @override
  Future<void> removeRecipe(String recipeTitle) async {
    final docRef = firebaseFirestore
    .collection('Suggestion')
    .doc('fetchedData')
    .collection('jechul')
    .doc(recipeTitle);

    await docRef.delete();
  }
}