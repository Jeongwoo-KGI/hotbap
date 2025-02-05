import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/data/data_source/api_recipe_repository.dart';
import 'package:hotbap/data/data_source/gemini_api.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/providers.dart';

class DetailPage extends ConsumerStatefulWidget {
  final Recipe recipe;

  DetailPage({required this.recipe, Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

// RecipeRepository Provider
final recipeRepositoryProvider = Provider<ApiRecipeRepository>((ref) {
  return ApiRecipeRepository(
    geminiApi: GeminiApi(dotenv.env['GEMINI_API_KEY']!), // .env에서 API 키 로드
    serviceKey: dotenv.env['FOOD_SAFETY_API_KEY']!, // .env에서 서비스 키 로드
  );
});

class _DetailPageState extends ConsumerState<DetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  List<Recipe> _recommendedRecipes = []; // 추천 레시피 리스트
  bool _isLoading = true; // 로딩 상태

  @override
  void initState() {
    super.initState();
    // 추천 레시피 가져오기
    fetchRecommendationRecipes();

    // 스크롤 감지하여 상태 업데이트
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset > 100 && !_isScrolled) {
          setState(() {
            _isScrolled = true;
          });
        } else if (_scrollController.offset <= 100 && _isScrolled) {
          setState(() {
            _isScrolled = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 컨트롤러 정리
    super.dispose();
  }

  Future<void> fetchRecommendationRecipes() async {
    final repository = ref.read(recipeRepositoryProvider);
    final recipes = await repository.getRecommendationRecipeDetailPage();

    if (!mounted) return; // 위젯이 dispose되었으면 setState() 호출 안 함

    setState(() {
      _recommendedRecipes = recipes;
      _isLoading = false;
    });
  }

  String processMaterialText(String text) {
    text = text.replaceAll(RegExp(r'●[^:]+:\s*|\n|재료\s*'), ',');
    List<String> ingredients = text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    return ingredients.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? "";
    final isFavorite =
        ref.watch(favoriteProvider(RecipeUid(widget.recipe, uid)));
    final processedMaterial = processMaterialText(widget.recipe.material);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white, // 단색 배경
          ),
        ),
        title: Text(
          '레시피',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              ref
                  .read(
                      favoriteProvider(RecipeUid(widget.recipe, uid)).notifier)
                  .toggleFavorite();
              if (!isFavorite) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color(0xFF4C4C4C).withOpacity(0.9),
                    behavior: SnackBarBehavior.fixed, // 떠 있는 형태
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    content: Row(
                      children: [
                        Expanded(
                            child: Text(
                          '나의 찜에서 \n저장한 레시피를 확인하실 수 있습니다',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.35,
                          ),
                        )),
                        Icon(
                          CupertinoIcons.heart_fill,
                          weight: 16,
                          color: Color(0xFFF70F36),
                        ),
                      ],
                    ),
                    duration: Duration(milliseconds: 2500), // 2.5초 후 사라짐
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: isFavorite ? Colors.red : Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 409,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.recipe.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    height: 26,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF05937),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Text(
                      widget.recipe.category,
                      style: TextStyle(
                        color: Color(0xFFFEF7F5),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.83,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.recipe.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 24,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 258,
                  child: Text(
                    '1인분',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                      height: 1.50,
                    ),
                  ),
                ),
                const SizedBox(height: 38),
                const Divider(
                  thickness: 0.5,
                  color: Color(0xFFE6E6E6),
                ),
                const SizedBox(height: 25),
                buildNutritionRow(),
                const SizedBox(height: 48),
                const Divider(
                  thickness: 0.5,
                  color: Color(0xFFE6E6E6),
                ),
                const SizedBox(height: 54),
                const Text(
                  '재료',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 1.38,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  processedMaterial,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w300,
                    height: 1.64,
                  ),
                ),
                const SizedBox(height: 48),
                const Divider(
                  thickness: 0.5,
                  color: Color(0xFFE6E6E6),
                ),
                const SizedBox(height: 18),

                manualListUi(),
                const SizedBox(height: 75),
                SizedBox(
                  width: double.infinity,
                  child: const Text(
                    '이런 레시피는 어때요?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                buildRecommendationList(), // 가로 스크롤 리스트뷰
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _isScrolled
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
              backgroundColor: Color(0xFFE33811),
              foregroundColor: Colors.white,
              elevation: 4, //버튼 그림자
            )
          : null,
    );
  }

  /// 추천 레시피 가로 리스트뷰
  Widget buildRecommendationList() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_recommendedRecipes.isEmpty) {
      return Center(child: Text('추천 레시피가 없습니다.'));
    }

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _recommendedRecipes.length,
        itemBuilder: (context, index) {
          final recipe = _recommendedRecipes[index];
          return Padding(
            padding: const EdgeInsets.only(right: 7),
            child: GestureDetector(
              onTap: () {
                // 클릭 시 상세 페이지 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(recipe: recipe),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: 121,
                    height: 118,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      image: recipe.imageUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(recipe.imageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 121,
                    child: Text(
                      recipe.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 121,
                    child: Text(
                      recipe.nutritionInfo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF7F7F7F),
                        fontSize: 10,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget manualListUi() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.recipe.manuals.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(height: 38),
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFCE3DD),
                borderRadius: BorderRadius.circular(43),
              ),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 1.10,
                ),
              ),
            ),
            const SizedBox(height: 38),
            Text(
              widget.recipe.manuals[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildNutritionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        nutritionLabelUi('열량', '${widget.recipe.calorie}', 'kcal', 65),
        nutritionLabelUi('탄수화물', '${widget.recipe.carbohydrate}', 'g', 60),
        nutritionLabelUi('단백질', '${widget.recipe.protein}', 'g', 60),
        nutritionLabelUi('지방', '${widget.recipe.fat}', 'g', 60),
        nutritionLabelUi('나트륨', '${widget.recipe.sodium}', 'g', 60),
      ],
    );
  }

  Column nutritionLabelUi(
      String title, String weight, String unit, double width) {
    return Column(
      children: [
        Container(
          height: 30,
          width: width,
          decoration: ShapeDecoration(
            color: Color(0xFFFEF7F5),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Color(0xFFFCE3DD),
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8), // 위쪽 모서리만 둥글게
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF842009),
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
        Container(
          height: 30,
          width: width,
          decoration: ShapeDecoration(
            color: Color(0xFFFEF7F5),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Color(0xFFFCE3DD),
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8), // 위쪽 모서리만 둥글게
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weight,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                ),
              ),
              Text(
                unit,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecipeUid {
  final Recipe recipe;
  final String uid;

  RecipeUid(this.recipe, this.uid);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeUid && other.recipe == recipe && other.uid == uid);

  @override
  int get hashCode => recipe.hashCode ^ uid.hashCode;
}
