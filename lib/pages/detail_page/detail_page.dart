import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/entity/user.dart' as userDomain;
import 'package:hotbap/providers.dart';

class DetailPage extends ConsumerWidget {
  final Recipe recipe;
  userDomain.User? user;

  DetailPage({required this.recipe, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    final uid = user!.uid; // UID 가져오기
    print('디테일페이지 uid:${uid}');

    final isFavorite = ref.watch(favoriteProvider(RecipeUid(recipe, uid)));
    print(recipe.title);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            Text(
              recipe.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 20,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // 즐겨찾기 추가/삭제 처리
                ref
                    .read(favoriteProvider(RecipeUid(recipe, uid)).notifier)
                    .toggleFavorite();
                print('isFavorite---$isFavorite');
              },
              child: Icon(
                isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: isFavorite ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 409,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(recipe.imageUrl),
                        fit: BoxFit.cover, // contain? cover?
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    alignment: Alignment.center,
                    width: 69,
                    height: 26,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF05937),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Text(
                      recipe.category,
                      style: TextStyle(
                        color: Color(0xFFFEF7F5),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.83,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    recipe.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 258,
                    child: Text(
                      recipe.lowSodiumTip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w300,
                        height: 1.50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Divider(),
                  const SizedBox(height: 28),
                  SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: [
                          //열량
                          Column(
                            children: [
                              Container(
                                  height: 30,
                                  width: 65,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFEF7F5),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color: Color(0xFFFCE3DD),
                                      ),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8), // 위쪽 모서리만 둥글게
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('열량')),
                              Container(
                                  height: 30,
                                  width: 65,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFEF7F5),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color: Color(0xFFFCE3DD),
                                      ),
                                      borderRadius: BorderRadius.vertical(
                                        bottom:
                                            Radius.circular(8), // 위쪽 모서리만 둥글게
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                      '${recipe.calorie.split('.')[0]}kcal'))
                            ],
                          ),
                          nutritionLabelUi(
                              '탄수화물', '${recipe.carbohydrate.split('.')[0]}g'),
                          SizedBox(width: 6),
                          nutritionLabelUi(
                              '단백질', '${recipe.protein.split('.')[0]}g'),
                          SizedBox(width: 6),

                          nutritionLabelUi(
                              '지방', '${recipe.fat.split('.')[0]}g'),
                          SizedBox(width: 6),

                          nutritionLabelUi(
                              '나트륨', '${recipe.sodium.split('.')[0]}g'),
                        ],
                      )),
                  SizedBox(
                    height: 28,
                  ),
                  const Text(
                    '재료',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1.38,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    recipe.material,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                      height: 1.50,
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Divider(),
                  SizedBox(
                    height: 6,
                  ),
                  manualListUi()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget manualListUi() {
    return ListView.builder(
      shrinkWrap: true, // 부모 위젯의 크기 제한 내에서 크기를 조정
      physics: const NeverScrollableScrollPhysics(), // 스크롤 방지 (부모의 스크롤뷰를 사용)
      itemCount: recipe.manuals.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: 38),
            // 번호를 보여주는 동그라미
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFFCE3DD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(43),
                ),
              ),
              child: Text(
                '${index + 1}', // 번호 (1부터 시작)
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 1.10,
                ),
              ),
            ),
            const SizedBox(height: 38),
            // 조리 순서 텍스트
            Text(
              recipe.manuals[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        );
      },
    );
  }

  Column nutritionLabelUi(String title, String weight) {
    return Column(
      children: [
        Container(
            height: 30,
            width: 60,
            decoration: ShapeDecoration(
              color: Color(0xFFFEF7F5),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFFCE3DD),
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8), // 위쪽 모서리만 둥글게
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(title)),
        Container(
            height: 30,
            width: 60,
            decoration: ShapeDecoration(
              color: Color(0xFFFEF7F5),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFFCE3DD),
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8), // 위쪽 모서리만 둥글게
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(weight))
      ],
    );
  }
}

class RecipeUid {
  final Recipe recipe;
  final String uid;

  RecipeUid(this.recipe, this.uid);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecipeUid && other.recipe == recipe && other.uid == uid;
  }

  @override
  int get hashCode => recipe.hashCode ^ uid.hashCode;
}
