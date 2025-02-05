import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotbap/pages/filter/filter_page.dart';

class LogoAndFilter extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22, top: 16, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/images/mainpage_logo.svg", height: 71.27, width: 66.72,),
          SizedBox(
            height: 44,
            width: 44,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xFF1A1717),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => 
                        FilterPage()
                      ));
                }, 
                //아이콘 변경 
                icon: Image.asset('assets/icons/filter.png'),
              ),
            ),
          ), 
        ],
      ),
    );
  }

}