import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoAndFilter extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22, top: 16, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 72,
            width: 67,
            child: SvgPicture.asset("assets/images/mainpage_logo.svg", height: 71.27, width: 66.72,)
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton.filledTonal(
              onPressed: (){}, //FIXME: send to profile fix page
              icon: const Icon(Icons.tune),
            ),
          ), 
        ],
      ),
    );
  }

}