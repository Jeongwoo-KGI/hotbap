class Recipe {
  final String title;
  final String nutritionInfo;
  final String imageUrl;
  final String ingredients;
  final String material; //재료
  final String category; //카테고리
  final String calorie; //열량
  final String carbohydrate; //탄수화물
  final String protein; //단백질
  final String fat; //지방
  final String sodium; //나트륨
  final List<String> manuals; // 조리 순서
  final String lowSodiumTip; //저염 팁

  Recipe({
    required this.title,
    required this.nutritionInfo,
    required this.imageUrl,
    required this.ingredients,
    required this.material,
    required this.category,
    required this.calorie,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
    required this.sodium,
    required this.manuals,
    required this.lowSodiumTip,
  });
}
