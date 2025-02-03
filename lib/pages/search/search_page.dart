import 'package:flutter/material.dart';
import 'package:hotbap/theme.dart';
import 'package:provider/provider.dart';
import '../../application/viewmodels/recipe_viewmodel.dart';
import '../../data/data_source/api_recipe_repository.dart';
import '../../data/data_source/gemini_api.dart';
import 'widgets/search_widget.dart';
import 'widgets/recipe_card.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String userQuery = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeViewModel(
        repository: ApiRecipeRepository(
          geminiApi: GeminiApi(dotenv.env['GEMINI_API_KEY']!),
          serviceKey: dotenv.env['FOOD_SAFETY_API_KEY']!,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      return SearchWidget(
                        onSearchSubmitted: (query) {
                          setState(() {
                            userQuery = query;
                          });
                        },
                        onCancelSearch: () {
                          setState(() {
                            userQuery = '';
                          });
                          Provider.of<RecipeViewModel>(context, listen: false).clearRecipes(); // 레시피 초기화
                        },
                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      userQuery.isEmpty ? '' : "'$userQuery' 검색결과",
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
                Expanded(
                  child: Consumer<RecipeViewModel>(

                    builder: (context, viewModel, child) { 
                      print(viewModel.recipes.length);
                      if (viewModel.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (viewModel.recipes.isEmpty && userQuery.isNotEmpty) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 252.0),
                            child: Text(
                              '검색 결과가 없습니다\n다시 입력해주세요',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                              ),
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
          bottomNavigationBar: BottomNavBar(initialIndex: 1),
        ),
      ),
    );
  }
}
