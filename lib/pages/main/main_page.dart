import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotbap/data/dto/user_dto.dart';
import 'package:hotbap/pages/main/widgets/logo_and_filter.dart';
import 'package:hotbap/pages/main/widgets/my_favorites.dart';
import 'package:hotbap/pages/main/widgets/say_hi.dart';
import 'package:hotbap/theme.dart';

/**
 * [Main Landing Page]
 * This page consists of showing recipie cards to the user. 
 * Starting from the logo, it contains the filter button, the recipie cards,
 * and page view of the recipies that are customized and tailored for daily usage
 */

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ToDo: get user data through impl later
    final user = FirebaseAuth.instance.currentUser;
    try {
      final query = FirebaseFirestore.instance
      .collection('user')
      .doc(user!.uid);
    } catch (e) {
      throw Exception('failed to get user data. $e');
    }
    final userName = ;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //logo and filter button
            LogoAndFilter(),
            Padding(
              padding: EdgeInsets.only(left: 22, bottom: 12, top: 25.73),
              child: SayHi(userName: userName),
            ),
            //Recipe Results
            //RecipeResult(),
            Padding(
              padding: EdgeInsets.only(left: 19),
              child: Container(
                height: 448,
                width: 339,
                decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/200/300"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    )),
              ),
            ),
            //Recipe My Favorites
            MyFavorites(),
            //Recipe Curated1
          ],
        ),
      ),
      bottomNavigationBar:
          BottomNavBar(initialIndex: 0), // 초기 인덱스를 설정하여 네비게이션 바 추가
    );
  }
}

Stream<UserDto?> fetchUser() {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('user unknown signin method');
    }

    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('user');
    final query = collectionRef.doc(user.uid);

    return query.snapshots().map((snapshot){
      if (snapshot.exists) {
        return UserDto.fromMap(snapshot.data()!);
      }
      throw Exception();
    });
  } catch (e) {
    throw Exception('no user found with uid. Error: $e');
  }
}