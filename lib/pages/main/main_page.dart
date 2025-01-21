import 'package:flutter/material.dart';

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

              //Name Say Hello Text

              //Recipe Results

              //Recipe My Favorites

              //Recipe Curated1

            ],
          ),
        ),
      ),
    );
  }
}