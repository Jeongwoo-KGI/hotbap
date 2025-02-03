import 'package:flutter/material.dart';
import '../../domain/repository/recipe_repository.dart';
import '../../domain/entity/recipe.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeRepository repository;

  RecipeViewModel({required this.repository});

  List<Recipe> _recipes = [];
  bool _isLoading = false;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;

  Future<void> searchRecipes(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _recipes = await repository.getRecipesBasedOnGemini(query);
    } catch (e) {
      _recipes = [];
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // 레시피 목록 초기화 메서드
  void clearRecipes() {
    _recipes.clear();
    notifyListeners();
  }
}
