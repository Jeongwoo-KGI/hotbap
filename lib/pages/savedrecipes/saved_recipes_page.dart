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
      appBar: AppBar(
        title: Text('찜리스트'),
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
              final recipe = Recipe(
                title: favorite['title'],
                nutritionInfo: favorite['nutritionInfo'],
                imageUrl: favorite['imageUrl'],
                ingredients: favorite['ingredients'],
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