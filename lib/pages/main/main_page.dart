import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotbap/pages/main/widgets/logo_and_filter.dart';
import 'package:hotbap/pages/main/widgets/recipe_result.dart';
import 'package:hotbap/pages/main/widgets/say_hi.dart';

/**
 * [Main Landing Page]
 * This page consists of showing recipie cards to the user. 
 * Starting from the logo, it contains the filter button, the recipie cards,
 * and page view of the recipies that are customized and tailored for daily usage
 */

class MainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final userName = "테스터"; //FIXME: 나중에 firebase로 업데이트 해둘것
    return SafeArea(
      child: Scaffold(
        body: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: <Widget> [
            //logo and filter button
            //LogoAndFilter(),
            Padding(
              padding: EdgeInsets.only(top: 16, right: 20, left: 22, bottom: 25.73),
              child: SvgPicture.asset("assets/images/mainpage_logo.svg", height: 71.27, width: 66.72,),
            ),
            //Name Say Hello Text
            Padding(
              padding: EdgeInsets.only(left: 22, bottom: 20),
              child: SayHi(userName: userName),
            ),
            //Recipe Results
            RecipeResult(),
            //Recipe My Favorites
        
            //Recipe Curated1
        
          ],
        ),
      ),
    );
  }
}