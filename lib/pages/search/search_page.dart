import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '검색',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              '취소',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 검색 바
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 41,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFCCCCCC)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Color(0xFFB3B3B3)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '검색',
                      style: TextStyle(
                        color: Color(0xFFB3B3B3),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 검색 결과
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '검색 결과 $index',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '탄20g 단2g 지2g',
                                style: TextStyle(
                                  color: Color(0xFF7F7F7F),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.timer, size: 14, color: Color(0xFF656565)),
                                      SizedBox(width: 4),
                                      Text(
                                        '20m',
                                        style: TextStyle(
                                          color: Color(0xFF656565),
                                          fontSize: 10,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  Row(
                                    children: [
                                      Icon(Icons.local_fire_department, size: 14, color: Color(0xFF656565)),
                                      SizedBox(width: 4),
                                      Text(
                                        '250kcal',
                                        style: TextStyle(
                                          color: Color(0xFF656565),
                                          fontSize: 10,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF989898)),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Color(0xFFD6512C)),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF989898)),
            label: '마이',
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
