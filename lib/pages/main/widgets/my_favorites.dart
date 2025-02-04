//This requires connection to the DB

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';
import 'package:hotbap/pages/main/widgets/individual_small.dart';

class MyFavorites extends StatefulWidget{
  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(user!.uid)
            .collection('favorites')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('저장된 레시피가 없습니다.'));
          }

          final recipeData = snapshot.data!.docs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, left: 20, bottom: 13),
              child: Text(
                "내가 저장한 레시피", 
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            Container(
              height: 170,
              padding: EdgeInsets.only(left: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recipeData.length,
                itemBuilder: (context, index){
                  final recipe = recipeData[index].data() as Map<String, dynamic>;
                  final input = Recipe.fromMap(recipe);
                  return GestureDetector(
                    child: individualSmallRecipe(input),
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => DetailPage(recipe: input), //(){} 방식은 에러 있음
                      ));
                    },
                  );
                }                
              ),
            ),
          ],
        );
      }
    );
  }
}

