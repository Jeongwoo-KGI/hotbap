import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/data/dto/recipe_dto.dart';

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
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    // 예시 API 엔드포인트
    final String apiUrl = 'https://example.com/api/recipes';

    // API 요청에 필요한 파라미터 설정
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
      // 필요하다면 추가 헤더를 설정하세요.
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        recipes = data.map((recipeJson) {
          final recipeDTO = RecipeDTO.fromJson(recipeJson);
          return recipeDTO.toEntity();
        }).toList();
        isLoading = false;
      });
    } else {
      // 에러 처리
      setState(() {
        isLoading = false;
      });
      print('Failed to load recipes');
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
            : ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return ListTile(
                    leading: Image.network(recipe.imageUrl),
                    title: Text(recipe.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recipe.ingredients),
                        SizedBox(height: 4),
                        Text(
                          '탄수화물: ${recipe.carbohydrate}, 단백질: ${recipe.protein}, 지방: ${recipe.fat}, 나트륨: ${recipe.sodium}',
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}