//This requires connection to the DB

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';

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

Widget individualSmallRecipe (Recipe recipe){ 
  String carbs = recipe.carbohydrate;
  String fat = recipe.fat;
  String protein = recipe.protein;
  String input = recipe.title;
  String imageURL = recipe.imageUrl;
  return Row(
    children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              width: 121,
              height: 118,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("$imageURL"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 6,),
            //name
            Text("$input", style: TextStyle(fontSize: 14, fontFamily: 'Pretendard', fontWeight: FontWeight.w600, color: Color(0xFF333333)),),
            //ratio
            Text("탄 ${carbs}g 단 ${protein}g 지 ${fat}g", style: TextStyle(fontSize: 10, fontFamily: 'Pretendard', fontWeight: FontWeight.w400, height: 1.50, color: Color(0xFF7F7F7F)),),
          ],
        ),
      ),
      SizedBox(width: 7,),
    ],
  );
}