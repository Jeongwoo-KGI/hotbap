import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';
import 'package:hotbap/domain/entity/recipe.dart';

class SavedRecipesPage extends StatelessWidget {
  final String userId;

  SavedRecipesPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 페이지 배경 색상 설정
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '나의 찜',
          textAlign: TextAlign.center, // 텍스트 가운데 정렬
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(userId)
            .collection('favorites')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('저장된 레시피가 없습니다.'));
          }

          final favorites = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              final favoriteData = favorite.data() as Map<String, dynamic>;
              final recipe = Recipe(
                title: favoriteData['title'],
                nutritionInfo: favoriteData['nutritionInfo'],
                imageUrl: favoriteData['imageUrl'],
                ingredients: favoriteData['ingredients'],
                material: favoriteData.containsKey('material') ? favoriteData['material'] : '기본 재료',
                category: favoriteData.containsKey('category') ? favoriteData['category'] : '',
                calorie: favoriteData.containsKey('calorie') ? favoriteData['calorie'] : '',
                carbohydrate: favoriteData.containsKey('carbohydrate') ? favoriteData['carbohydrate'] : '',
                protein: favoriteData.containsKey('protein') ? favoriteData['protein'] : '',
                fat: favoriteData.containsKey('fat') ? favoriteData['fat'] : '',
                sodium: favoriteData.containsKey('sodium') ? favoriteData['sodium'] : '',
                manuals: favoriteData.containsKey('manuals') ? List<String>.from(favoriteData['manuals']) : [],
                lowSodiumTip: favoriteData.containsKey('lowSodiumTip') ? favoriteData['lowSodiumTip'] : '',
              );

              return ListTile(
                leading: Image.network(recipe.imageUrl),
                title: Text(recipe.title),
                subtitle: Text(recipe.nutritionInfo),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(recipe: recipe),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}