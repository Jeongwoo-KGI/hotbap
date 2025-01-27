import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FirebaseFirestore firebaseFirestore;

  FavoriteRepositoryImpl({required this.firebaseFirestore});

  @override
  Future<void> addFavorite(String userId, Recipe recipe) async {
    final docRef = firebaseFirestore
        .collection('user')
        .doc(userId)
        .collection('favorites')
        .doc(recipe.title);

    await docRef.set({
      'title': recipe.title,
      'nutritionInfo': recipe.nutritionInfo,
      'imageUrl': recipe.imageUrl,
      'ingredients': recipe.ingredients,
    });
  }

  @override
  Future<void> removeFavorite(String userId, String recipeTitle) async {
    final docRef = firebaseFirestore
        .collection('user')
        .doc(userId)
        .collection('favorites')
        .doc(recipeTitle);

    await docRef.delete(); // 해당 레시피를 즐겨찾기에서 삭제
  }

  @override
  Future<bool> isFavorite(String userId, String recipeTitle) async {
    final docRef = firebaseFirestore
        .collection('user')
        .doc(userId)
        .collection('favorites')
        .doc(recipeTitle);

    final docSnapshot = await docRef.get();
    return docSnapshot.exists; // 해당 레시피가 즐겨찾기에 있는지 확인
  }
}
