import 'package:hotbap/domain/entity/recipe.dart';

class RecipeDTO {
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

  RecipeDTO({
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

  factory RecipeDTO.fromJson(Map<String, dynamic> json) {
    // "MANUAL01" ~ "MANUAL20" 값을 순서대로 담기
    List<String> manualList = [];
    for (int i = 1; i <= 20; i++) {
      String key =
          'MANUAL${i.toString().padLeft(2, '0')}'; // "MANUAL01", "MANUAL02" ...

      if (json[key] != null && json[key].toString().isNotEmpty) {
        String manualText = json[key].toString();
        // 1~2번째 글자가 '. '이면 삭제
        if (manualText.length >= 2 && manualText.substring(1, 3) == '. ') {
          manualText = manualText.substring(2); // 0~2번째 글자 삭제
        }

        manualList.add(manualText);
      }
    }

    return RecipeDTO(
      title: json['RCP_NM'] ?? '제목 없음',
      nutritionInfo:
          '탄${json['INFO_CAR'] ?? 0}g 단${json['INFO_PRO'] ?? 0}g 지${json['INFO_FAT'] ?? 0}g',
      imageUrl: json['ATT_FILE_NO_MAIN'] ?? '',
      ingredients: json['RCP_PARTS_DTLS'] ?? '정보 없음',
      material: json['RCP_PARTS_DTLS'] ?? '',
      category: json['RCP_PAT2'] ?? '',
      calorie: json['INFO_ENG'] ?? '',
      carbohydrate: json['INFO_CAR'] ?? '',
      protein: json['INFO_PRO'] ?? '',
      fat: json['INFO_FAT'] ?? '',
      sodium: json['INFO_NA'] ?? '',
      manuals: manualList,
      lowSodiumTip: json['RCP_NA_TIP'] ?? '',
    );
  }

  Recipe toEntity() {
    return Recipe(
      title: title,
      nutritionInfo: nutritionInfo,
      imageUrl: imageUrl,
      ingredients: ingredients,
      material: material,
      category: category,
      calorie: calorie,
      carbohydrate: carbohydrate,
      protein: protein,
      fat: fat,
      sodium: sodium,
      manuals: manuals,
      lowSodiumTip: lowSodiumTip,
    );
  }
}
