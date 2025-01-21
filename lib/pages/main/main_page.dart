import 'package:flutter/material.dart';
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
        appBar: AppBar(),
        body: Align(
          alignment: Alignment.center,//align with center
          child: ListView(
            
            children: [
              //logo and filter button
              LogoAndFilter(),
              //Name Say Hello Text
              SayHi(userName: userName),
              //Recipe Results
              RecipeResult(),
              //Recipe My Favorites
              
              //Recipe Curated1

            ],
          ),
        ),
      ),
    );
  }
}