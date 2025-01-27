import 'package:flutter/material.dart';

class Button extends StatelessWidget{
  int width;
  String content;

  Button({required this.width, required this.content})
  @override
  Widget build(BuildContext context) {
    //white button become red on tap
    return OutlinedButton(
      onPressed: (){
        //button action
      },
      //button shape
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1, color: Color(0xFFE6E6E6), strokeAlign: BorderSide.strokeAlignOutside),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      //button text
      child: Text(
        "$content", 
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          height: 1.50, 
          color: Color(0xFF333333),
        ),));
  }
}