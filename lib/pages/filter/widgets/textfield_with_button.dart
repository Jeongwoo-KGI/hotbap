import 'package:flutter/material.dart';
import 'package:hotbap/pages/filter/widgets/button.dart';

class TextfieldWithButton extends StatelessWidget{
  String input;
  List<String> content;
  //controller


  TextfieldWithButton({required this.input, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 335,
          child: Text(
            "$input",
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 29,
          width: 335,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //for loop widget
              for (int i = 1; i<content.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Button(content: content[i]),
                )
            ],
          ),
        )
      ],
    );
  }
}