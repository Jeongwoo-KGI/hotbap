import 'package:flutter/material.dart';
import 'package:hotbap/pages/filter/widgets/just_buttons.dart';

class FilterPage extends StatefulWidget{

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  TextEditingController keywordController = TextEditingController();
  TextEditingController favoriteIngredientsController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void dispose() {
    keywordController.dispose();
    favoriteIngredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "상세필터",
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            height: 1.35
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //ToDo: add 키워드, 좋아하는 재료 after connecting with the DB
            SizedBox(height: 32),
            JustButtons(input: "날씨", content: ["날씨좋음", "비가 올 때", "눈이 올 때"]),
            SizedBox(height: 32),
            JustButtons(input: "계절", content: ["봄", "여름","가을","겨울"]),

            //Buttons for Refresh and Search Results
            SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                //reset button
                Container(
                  width: 110,
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFB3B3B3)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Icon(Icons.rotate_left_outlined),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "초기화",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Search Result Button
                Container(
                  width: 218,
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 14),
                  decoration: ShapeDecoration(
                    color: Color(0xFFCCCAc9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '검색결과',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
        ],),
      ),
    );
  }
}