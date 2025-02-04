//제철음식 @ 한반도

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/data/data_source/api_recipe_repository.dart';
import 'package:hotbap/data/data_source/gemini_api.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';
import 'package:hotbap/pages/main/widgets/individual_small.dart';
import 'package:intl/intl.dart';

Map<String, List<String>> jechul = {
  //add the elements 
  //reference : https://blog.naver.com/kimwhddms/221766076576
  //only parts of the elements from the blog post has been added. 
  'Jan': ['잣', '자몽', '한라봉', '레드향', '다금바리', '도미', '돌돔', '방어', '빙어', '산천어', '조기', '낙지'],
  'Feb': ['피조개', '홍게', '꼬막', '홍어', '숭어', '벵에돔', '딸기', '시금치'],
  'Mar': ['취나물', '표고버섯', '우엉', '연근', '야콘', '애호박', '양배추', '쑥', '미나리'],
  'Apr': ['마늘', '머위', '부추', '두릅', '돌나물', '더덕', '달래', '냉이', '가지', '고사리'],
  'May': ['완두콩', '매실', '능성어', '메로', '병어', '부세', '우럭', '장어', '전갱이', '참돔'],
  'Jun': ['군소', '다슬기', '성게', '소라', '재첩', '한치', '가지', '감자', '근대', '복분자', '양파'],
  'Jul': ['치커리', '옥수수', '오이', '여주', '양상추', '블루베리', '도라지', '근대', '청각'],
  'Aug': ['복숭아', '오렌지', '자두', '참외', '수박', '메론', '포도', '갈치', '농어', '민어', '전복'],
  'Sep': ['당근', '대파', '방아잎', '생강', '야콘', '은행', '토마토', '아보카도', '표고버섯'],
  'Oct': ['쪽파', '연근', '시레기', '송이버섯', '생강', '밤', '마', '대파', '당근', '늙은호박'],
  'Nov': ['갓', '홍합', '해삼', '오징어', '새우', '문어', '매생이', '낙지', '굴', '과메기', '참조기'],
  'Dec': ['삼치', '빙어', '명태', '돌돔', '도미', '까나리', '귤', '잣', '피조개', '브로콜리'],
};

//FixMe: 재료를 하나 입력하는것으로 결과가 안나오는데..? 제미나이 거치지 않고 결과를 내는 방식으로 바꿀것
class JechulFoodRec extends ConsumerStatefulWidget{
  @override
  _JechulFoodRecState createState() => _JechulFoodRecState();
}

final recipeRepositoryProvider = Provider<ApiRecipeRepository> ((ref){
  return ApiRecipeRepository(
    geminiApi: GeminiApi(dotenv.env['GEMINI_API_KEY']!),
    serviceKey: dotenv.env['FOOD_SAFETY_API_KEY']!,
  );
});

class _JechulFoodRecState extends ConsumerState<JechulFoodRec> {
  String monthName = DateFormat("MMM").format(DateTime.now());
  List<String> currentJechul = [];
  List<Recipe> resultRecipes = [];
  bool _isLoading = true;

  void initState() {
    super.initState();
    jechulRecipes();
  }

  Future<void> jechulRecipes() async {
    //fecth the jechul ingredients of this month
    List<String> currentallJechul = jechul[monthName]!;
    final random = new Random();
    //get current jechul ingredients up to 4
    // for (int i = 0; i<4; i++){
    //   currentJechul.add(currentallJechul[random.nextInt((currentallJechul.length))]);
    // }
    currentJechul = currentallJechul;
    //query 4 ingredients of jechul and get results
    final repository = ref.read(recipeRepositoryProvider);
    List<Recipe> recipes = [];
    for(int i = 0;i<currentJechul.length;i++){
      recipes += await repository.getJechulRecipeWithoutGemini(currentJechul[i]);
    }
    setState(() {
      resultRecipes = recipes;
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (resultRecipes.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top:40, left: 20, bottom: 13),
            child: Text(
              "제철음식 추천",
              style: TextStyle(              
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),),
            ),
          ),
          Container(
            height: 170,
            child: Text(
              //if currentJechul != currentallJechul
              //"제철재료 음식 없음: 이달의 제철 재료 $currentJechul",
              "제철재료 음식 없음: 이달의 제철 재료 ${currentJechul[Random().nextInt((currentJechul.length))]}",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w300,
                color: Color(0xFF333333),
              ),
            ),
          ),
          
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40, left: 20, bottom: 13),
          child: Text(
            "제철음식 추천",
              style: TextStyle(
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
        ),
        Container(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: resultRecipes.length,
            itemBuilder: (context, index){
              final recipe = resultRecipes[index];
              final input = recipe;
              return GestureDetector(
                child: individualSmallRecipe(input),
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => DetailPage(recipe: input), //(){} 방식은 에러 있음
                  ));
                },
              );
            }                
          ),
        ),
      ],
    );
  }
}