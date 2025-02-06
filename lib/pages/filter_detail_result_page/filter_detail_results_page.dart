import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/data/dto/recipe_dto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotbap/data/data_source/gemini_api.dart';
import 'package:hotbap/pages/search/widgets/recipe_card.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart'; 

class FilterDetailResultsPage extends StatefulWidget {
  final List<String> selectedTags;

  FilterDetailResultsPage({required this.selectedTags});

  @override
  _FilterDetailResultsPageState createState() => _FilterDetailResultsPageState();
}

class _FilterDetailResultsPageState extends State<FilterDetailResultsPage> {
  List<Recipe> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipesBasedOnFilters();
  }

  Future<void> fetchRecipesBasedOnFilters() async {
    try {
      final geminiApi = GeminiApi(dotenv.env['GEMINI_API_KEY']!);
      final String filterQuery = widget.selectedTags.join(', ');
      final List<String> recommendedRecipeNames =
          await geminiApi.getRecommendedRecipeNames(filterQuery);

      List<Recipe> fetchedRecipes = [];
      for (String recipeName in recommendedRecipeNames) {
        final String apiUrl =
            'https://openapi.foodsafetykorea.go.kr/api/${dotenv.env['FOOD_SAFETY_API_KEY']!}/COOKRCP01/json/1/5/RCP_NM=$recipeName';

        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['COOKRCP01']['row'] != null) {
            final List<dynamic> recipeData = data['COOKRCP01']['row'];
            fetchedRecipes.addAll(recipeData.map((json) {
              final recipeDTO = RecipeDTO.fromJson(json);
              return recipeDTO.toEntity();
            }).toList());
          }
        } else {
          print('Failed to fetch recipe for $recipeName');
        }
      }

      setState(() {
        recipes = fetchedRecipes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching recipes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.filter_list, color: Color(0xFF333333)),
        title: Text(
          '상세필터 결과',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Color(0xFF333333)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : recipes.isEmpty
                ? Center(
                    child: Text(
                      '검색 결과가 없습니다.',
                      style: TextStyle(
                        color: Color(0xFF7F7F7F),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(recipe: recipe), // DetailPage로 이동
                            ),
                          );
                        },
                        child: RecipeCard(recipe: recipe),
                      );
                    },
                  ),
      ),
    );
  }
}

