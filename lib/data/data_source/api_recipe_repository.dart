import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entity/recipe.dart';
import '../../domain/repository/recipe_repository.dart';
import '../dto/recipe_dto.dart';
import 'gemini_api.dart';
import 'dart:math';

class ApiRecipeRepository implements RecipeRepository {
  final String _baseUrl = 'https://openapi.foodsafetykorea.go.kr/api';
  final String _serviceKey;
  final GeminiApi geminiApi;

  ApiRecipeRepository({required this.geminiApi, required String serviceKey})
      : _serviceKey = serviceKey;

  @override
  Future<List<Recipe>> getRecipesBasedOnGemini(String query) async {
    final recommendedRecipeNames =
        await geminiApi.getRecommendedRecipeNames(query);
    List<Recipe> recipes = [];

    for (final recipeName in recommendedRecipeNames) {
      final url = Uri.parse(
          '$_baseUrl/$_serviceKey/COOKRCP01/json/1/10/RCP_NM=$recipeName');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['COOKRCP01']['row'] != null) {
          final recipeData = data['COOKRCP01']['row'] as List;

          // Use RecipeDTO to map API data
          recipes.addAll(
              recipeData.map((json) => RecipeDTO.fromJson(json).toEntity()));
        }
      }
    }

    return recipes;
  }

  //디테일페이지에서 사용
  Future<List<Recipe>> getRecommendationRecipeDetailPage() async {
    int num = Random().nextInt(1000) + 1;
    final url =
        Uri.parse('$_baseUrl/$_serviceKey/COOKRCP01/json/$num/${num + 5}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['COOKRCP01']['row'] != null) {
        final recipeData = data['COOKRCP01']['row'] as List;
        return recipeData
            .map((json) => RecipeDTO.fromJson(json).toEntity())
            .toList();
      }
    }
    return [];
  }
}
