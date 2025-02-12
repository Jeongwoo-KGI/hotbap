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
              padding: EdgeInsets.all(8),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Color(0xFF1A1717),
              ),

              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilterPage() 
                    ),
                  );
                },
                child: Image.asset('assets/icons/Filter.png', height: 24, width: 24,),
              ),
            ),
          ),

        ],
      ),
    );
  }

}