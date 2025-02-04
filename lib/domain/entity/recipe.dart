import 'package:hotbap/data/dto/recipe_dto.dart';

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

  factory Recipe.fromDto(RecipeDTO dto) {
    return Recipe(
    title: dto.title,
    nutritionInfo: dto.nutritionInfo,
    imageUrl: dto.imageUrl,
    ingredients: dto.ingredients,
    material: dto.material,
    category: dto.category,
    calorie: dto.calorie,
    carbohydrate: dto.carbohydrate,
    protein: dto.protein,
    fat: dto.fat,
    sodium: dto.sodium,
    manuals: dto.manuals,
    lowSodiumTip: dto.lowSodiumTip,
    );
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    List<String> manualList = List<String>.from(map['manuals'] as List);
    return Recipe(
    title: map['title'],
    nutritionInfo: map['nutritionInfo'],
    imageUrl: map['imageUrl'],
    ingredients: map['ingredients'],
    material: map['material'],
    category: map['category'],
    calorie: map['calorie'],
    carbohydrate: map['carbohydrate'],
    protein: map['protein'],
    fat: map['fat'],
    sodium: map['sodium'],
    manuals: manualList,
    lowSodiumTip: map['lowSodiumTip'],
    );
  }
}
