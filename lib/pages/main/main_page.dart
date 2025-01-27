import 'package:flutter/material.dart';
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
    final userName = "테스터"; //FIXME: 나중에 firebase로 업데이트 해둘것
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
