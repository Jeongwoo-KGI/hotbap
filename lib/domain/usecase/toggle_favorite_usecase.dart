import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/repository/favorite_repository.dart';

class ToggleFavoriteUseCase {
  final FavoriteRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<bool> execute(String userId, Recipe recipe) async {
    final isFavorite =
        await repository.isFavorite(userId, recipe.title); // 즐겨찾기 여부 확인
    if (isFavorite) {
      await repository.removeFavorite(userId, recipe.title); // 즐겨찾기에서 삭제
    } else {
      await repository.addFavorite(userId, recipe); // 즐겨찾기에 추가
    }
    return !isFavorite; // 새로운 즐겨찾기 상태 반환
  }
}
