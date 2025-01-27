import 'package:hotbap/domain/entity/recipe.dart';

/// FavoriteRepository Interface
abstract class FavoriteRepository {
  // 즐겨찾기 추가
  Future<void> addFavorite(String userId, Recipe recipe);

  // 즐겨찾기 삭제
  Future<void> removeFavorite(String userId, String recipeTitle);

  // 레시피가 즐겨찾기 목록에 있는지 확인
  Future<bool> isFavorite(String userId, String recipeTitle);
}
