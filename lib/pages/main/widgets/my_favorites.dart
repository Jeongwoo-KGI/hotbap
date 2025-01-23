//This requires connection to the DB

import 'package:flutter/material.dart';

class MyFavorites extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40, left: 20, bottom: 13),
          child: Text(
            "내가 저장한 레시피", //FIXME: to a page for 더보기
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              //these should be the recipes
              SizedBox(width: 20,), 
              individualSmallRecipe("아보카도 샌드위치"),
              individualSmallRecipe("바질 파스타"),
              individualSmallRecipe("바질 파스타"),
              individualSmallRecipe("바질 파스타"),
              individualSmallRecipe("바질 파스타"),
              individualSmallRecipe("바질 파스타"),
          
            ],
          ),
        ),
      ],
    );
  }
}

Widget individualSmallRecipe (String input){ //FixMe: this should be class Recipe later
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image
          Container(
            width: 121,
            height: 118,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/200/300"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          SizedBox(height: 6,),
          //name
          Text("$input", style: TextStyle(fontSize: 14, fontFamily: 'Pretendard', fontWeight: FontWeight.w600, color: Color(0xFF333333)),),
          //ratio
          Text("탄 10g 단 10g 지 5g", style: TextStyle(fontSize: 10, fontFamily: 'Pretendard', fontWeight: FontWeight.w400, height: 1.50, color: Color(0xFF7F7F7F)),),
        ],
      ),
      SizedBox(width: 7,),
    ],
  );
}