import 'package:flutter/material.dart';
import 'package:hotbap/pages/containter_page.dart/container_page.dart';
import 'package:hotbap/pages/filter/filter_selected_list.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/pages/filter/widgets/filter_page_widget.dart';
import 'package:hotbap/pages/filter_detail_result_page/filter_detail_results_page.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController ingredientController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> defaultCategories = [
    '혼밥',
    '귀찮을때',
    '데이트',
    '친구와 함께',
    '단백질이 많은',
  ];

  List<String> defaultIngredients = [
    '감자',
    '닭',
    '콩나물',
    '계란',
    '헛개열매',
  ];

  List<String> categories = [];
  List<String> ingredients = [];

  List<String> weather = [
    '날씨 좋을 때',
    '비가 올 때',
    '눈이 올 때',
  ];

  List<String> seasons = [
    '봄',
    '여름',
    '가을',
    '겨울',
  ];

  @override
  void initState() {
    super.initState();
    categories.addAll(defaultCategories);
    ingredients.addAll(defaultIngredients);
  }

  @override
  void dispose() {
    categoryController.dispose();
    ingredientController.dispose();
    super.dispose();
  }

  void goToDetailResultsPage() {
    print(filterSelectedList);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterDetailResultsPage(selectedTags: filterSelectedList), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContainerPage()),
            );
          },
        ),
        title: Text(
          '상세 필터', // 타이틀 텍스트 변경
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
        centerTitle: true, // 가운데 정렬 설정
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF333333)),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    buildSectionWithInput(
                      '카테고리',
                      categories,
                      categoryController,
                      (value) {
                        setState(() {
                          categories.add(value);
                        });
                      },
                    ),
                    buildSectionWithInput(
                      '좋아하는 재료',
                      ingredients,
                      ingredientController,
                      (value) {
                        setState(() {
                          ingredients.add(value);
                        });
                      },
                    ),
                    buildSectionWithoutInput('날씨', weather),
                    buildSectionWithoutInput('계절', seasons),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16), // 버튼들을 위로 올리기 위해 추가한 공간
            Container(
              width: 376,
              height: 88,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          categories = List.from(defaultCategories);
                          ingredients = List.from(defaultIngredients);
                          categoryController.clear();
                          ingredientController.clear();
                        });
                      },
                      child: Container(
                        height: 56,
                        width: 110,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFB3B3B3)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.rotate_left_outlined, color: Color(0xFF333333)),
                            SizedBox(width: 8),
                            Text(
                              '초기화',
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
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: goToDetailResultsPage, // 검색 버튼 클릭 시 페이지 이동 함수 호출
                      child: Container(
                        height: 56,
                        width: 218,
                        decoration: ShapeDecoration(
                          color: Color(0xFFE33811),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '필터결과 보기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16), // 버튼들을 위로 올리기 위해 추가한 공간
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
