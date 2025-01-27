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
        ],),
      ),
    );
  }
}