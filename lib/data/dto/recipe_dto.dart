import 'package:hotbap/domain/entity/recipe.dart';

class RecipeDTO {
  final String title;
  final String nutritionInfo;
  final String imageUrl;
  final String ingredients;

  RecipeDTO({
    required this.title,
    required this.nutritionInfo,
    required this.imageUrl,
    required this.ingredients,
  });

  factory RecipeDTO.fromJson(Map<String, dynamic> json) {
    return RecipeDTO(
      title: json['RCP_NM'] ?? '제목 없음',
      nutritionInfo: '탄${json['INFO_CAR'] ?? 0}g 단${json['INFO_PRO'] ?? 0}g 지${json['INFO_FAT'] ?? 0}g',
      imageUrl: json['ATT_FILE_NO_MAIN'] ?? '',
      ingredients: json['RCP_PARTS_DTLS'] ?? '정보 없음',
    );
  }

  Recipe toEntity() {
    return Recipe(
      title: title,
      nutritionInfo: nutritionInfo,
      imageUrl: imageUrl,
      ingredients: ingredients,
    );
  }
}
