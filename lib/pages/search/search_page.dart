import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Domain Layer
class Recipe {
  final String title;
  final String nutritionInfo;
  final String cookingTime;
  final String calories;
  final String imageUrl;

  Recipe({
    required this.title,
    required this.nutritionInfo,
    required this.cookingTime,
    required this.calories,
    required this.imageUrl,
  });
}

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipesBasedOnGemini(String query);
}

//Data Layer
class GeminiApi {
  final String apiKey;

  GeminiApi(this.apiKey);

  Future<List<String>> getRecommendedRecipeNames(String query) async {
    final schema = Schema.array(
      description: 'List of recommended recipe names',
      items: Schema.object(properties: {
        'recipeName': Schema.string(description: 'Name of the recipe', nullable: false),
      }, requiredProperties: ['recipeName']),
    );

    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: schema,
      ),
    );

    final prompt = '쿼리를 토대로 5개의 레시피를 한글로 알려줘: $query';
    final response = await model.generateContent([Content.text(prompt)]);

    if (response.text != null) {
      final List<dynamic> responseData = json.decode(response.text!);
      return responseData.map((recipe) => recipe['recipeName'] as String).toList();
    } else {
      throw Exception('Response text is null');
    }
  }
}

class ApiRecipeRepository implements RecipeRepository {
  final String _baseUrl = 'https://openapi.foodsafetykorea.go.kr/api';
  final String _serviceKey;
  final GeminiApi geminiApi;

  ApiRecipeRepository({required this.geminiApi, required String serviceKey})
      : _serviceKey = serviceKey;

  @override
  Future<List<Recipe>> getRecipesBasedOnGemini(String query) async {
    final recommendedRecipeNames = await geminiApi.getRecommendedRecipeNames(query);
    print('Recommended Recipe Names: $recommendedRecipeNames');
    List<Recipe> recipes = [];

    for (final recipeName in recommendedRecipeNames) {
      final url = Uri.parse('$_baseUrl/$_serviceKey/COOKRCP01/json/1/10/RCP_NM=$recipeName');

      final response = await http.get(url);
      print('API Response: $response');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('API Data: $data');
        if (data['COOKRCP01']['row'] != null) {
          final recipeData = data['COOKRCP01']['row'] as List;

          recipes.addAll(recipeData.map((recipe) {
            return Recipe(
              title: recipe['RCP_NM'] ?? '제목 없음',
              nutritionInfo: recipe['INFO_NA'] ?? '정보 없음',
              cookingTime: recipe['INFO_CAR'] ?? '정보 없음',
              calories: recipe['INFO_ENG'] ?? '정보 없음',
              imageUrl: recipe['ATT_FILE_NO_MAIN'] ?? '',
            );
          }));
        }
      } else {
        print('Failed to fetch recipe for $recipeName');
      }
    }

    return recipes;
  }
}

// --- Application Layer --- //
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
}

// --- Presentation Layer --- //
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeViewModel(
        repository: ApiRecipeRepository(
          geminiApi: GeminiApi(dotenv.env['GEMINI_API_KEY']!),
          serviceKey: dotenv.env['FOOD_SAFETY_API_KEY']!,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // 검색 바
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBar(),
            ),
            // 검색 결과
            Expanded(
              child: Consumer<RecipeViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (viewModel.recipes.isEmpty) {
                    return Center(
                      child: Text(
                        '검색 결과가 없습니다.',
                        style: TextStyle(
                          color: Color(0xFF7F7F7F),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: viewModel.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = viewModel.recipes[index];
                      return RecipeCard(recipe: recipe);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Color(0xFFB3B3B3)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '검색',
                hintStyle: TextStyle(
                  color: Color(0xFFB3B3B3),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  Provider.of<RecipeViewModel>(context, listen: false).searchRecipes(query);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
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
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    recipe.nutritionInfo,
                    style: TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, size: 14, color: Color(0xFF656565)),
                          SizedBox(width: 4),
                          Text(
                            recipe.cookingTime,
                            style: TextStyle(
                              color: Color(0xFF656565),
                              fontSize: 10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department, size: 14, color: Color(0xFF656565)),
                          SizedBox(width: 4),
                          Text(
                            recipe.calories,
                            style: TextStyle(
                              color: Color(0xFF656565),
                              fontSize: 10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
