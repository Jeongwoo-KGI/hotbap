import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/viewmodels/recipe_viewmodel.dart';
import '../../data/data_source/api_recipe_repository.dart';
import '../../data/data_source/gemini_api.dart';
import 'widgets/search_widget.dart';
import 'widgets/recipe_card.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeViewModel(
        repository: ApiRecipeRepository(
          geminiApi:
              GeminiApi(dotenv.env['GEMINI_API_KEY']!), // .env에서 API 키 로드
          serviceKey: dotenv.env['FOOD_SAFETY_API_KEY']!, // .env에서 서비스 키 로드
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
            // 검색 결과 타이틀
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  '검색결과',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(recipe: recipe),
                            ),
                          );
                        },
                        child: RecipeCard(recipe: recipe),
                      );
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
