import 'package:flutter/material.dart';
import 'package:hotbap/pages/filter/widgets/just_buttons.dart';
import 'package:hotbap/pages/filter/widgets/input_box.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/pages/filter/widgets/tag_box.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
        ),
        title: Text(
          '상세필터',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            height: 1.35,
          ),
        ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionWithInput(
                      '카테고리',
                      categories,
                      categoryController,
                      (value) {
                        setState(() {
                          categories.add(value);
                        });
                      },
                    ),
                    _buildSectionWithInput(
                      '좋아하는 재료',
                      ingredients,
                      ingredientController,
                      (value) {
                        setState(() {
                          ingredients.add(value);
                        });
                      },
                    ),
                    _buildSectionWithoutInput('날씨', weather),
                    _buildSectionWithoutInput('계절', seasons),
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
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("검색 결과"),
                              content: Text("검색 결과가 여기 표시됩니다."),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('닫기'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 56,
                        decoration: ShapeDecoration(
                          color: Color(0xFFE33811),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '검색결과 5건',
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

  Widget _buildSectionWithInput(
    String title,
    List<String> options,
    TextEditingController controller,
    Function(String) onSubmitted,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        InputBox(
          controller: controller,
          label: title == '카테고리' ? '재료를 입력해주세요' : '재료를 입력해주세요', // 라벨 텍스트 설정
          onSubmitted: (value) {
            setState(() {
              options.add(value);
            });
          },
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 9, // 줄 간격 추가
          children: options.map((option) {
            return TagBox(
              text: option,
              initiallySelected: !defaultCategories.contains(option) && !defaultIngredients.contains(option),
              onRemove: () {
                setState(() {
                  options.remove(option);
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSectionWithoutInput(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 9, // 줄 간격 추가
          children: options.map((option) {
            return TagBox(
              text: option,
              onRemove: () {
                setState(() {
                  options.remove(option);
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}