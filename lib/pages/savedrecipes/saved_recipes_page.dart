import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/svg/arrow_m_left.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
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

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: 334,
                  height: 100,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이콘을 오른쪽 끝으로 이동
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 84,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            recipe.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16), // 이미지와 텍스트 간의 간격
                      Expanded( // 남은 공간을 채움
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150, // 이름 길이 제한
                              child: Text(
                                recipe.title,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 1.35,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(height: 8), // 텍스트 간의 간격
                            Container(
                              width: 150,
                              child: Text(
                                '탄${recipe.carbohydrate}g 단${recipe.protein}g 지${recipe.fat}g',
                                style: TextStyle(
                                  color: Color(0xFF7F7F7F),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/svg/heart_selected.svg'),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(userId)
                              .collection('favorites')
                              .doc(favorite.id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}