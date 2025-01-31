import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/entity/user.dart' as userDomain;
import 'package:hotbap/providers.dart';

class DetailPage extends ConsumerStatefulWidget {
  final Recipe recipe;

  DetailPage({required this.recipe, Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();

    // 스크롤 감지하여 상태 업데이트
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset > 100 && !_isScrolled) {
          setState(() {
            _isScrolled = true;
          });
        } else if (_scrollController.offset <= 100 && _isScrolled) {
          setState(() {
            _isScrolled = false;
          });
        }
      }
    });
  }

  String processMaterialText(String text) {
    text = text.replaceAll(RegExp(r'●[^:]+:\s*|\n|재료\s*'), ',');
    List<String> ingredients = text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    return ingredients.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? "";
    final isFavorite =
        ref.watch(favoriteProvider(RecipeUid(widget.recipe, uid)));
    final processedMaterial = processMaterialText(widget.recipe.material);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white, // 단색 배경
          ),
        ),
        title: Row(
          children: [
            const Spacer(),
            Text(
              widget.recipe.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                ref
                    .read(favoriteProvider(RecipeUid(widget.recipe, uid))
                        .notifier)
                    .toggleFavorite();
                if (!isFavorite) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Expanded(
                              child: Text('나의 찜에서 \n저장한 레시피를 확인하실 수 있습니다')),
                          Icon(
                            CupertinoIcons.heart_fill,
                            weight: 16,
                            color: Color(0xFFF70F36),
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 2500), // 2.5초 후 사라짐
                    ),
                  );
                }
              },
              child: Icon(
                isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: isFavorite ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 409,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.recipe.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const SizedBox(height: 24),
                Text(widget.recipe.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Text(widget.recipe.lowSodiumTip,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 28),
                const Divider(),
                const SizedBox(height: 28),
                buildNutritionRow(),
                const SizedBox(height: 28),
                const Divider(),
                const SizedBox(height: 28),
                const Text('재료',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Text(processedMaterial,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 28),
                const Divider(),
                manualListUi(),
                const SizedBox(height: 44),
                const Text('이런 레시피는 어때요?',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 13),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _isScrolled
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 4,
            )
          : null,
    );
  }

  Widget manualListUi() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.recipe.manuals.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(height: 38),
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFCE3DD),
                borderRadius: BorderRadius.circular(43),
              ),
              child: Text('${index + 1}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 38),
            Text(widget.recipe.manuals[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14)),
          ],
        );
      },
    );
  }

  Widget buildNutritionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        nutritionLabelUi('열량', '${widget.recipe.calorie.split('.')[0]}kcal'),
        nutritionLabelUi(
            '탄수화물', '${widget.recipe.carbohydrate.split('.')[0]}g'),
        nutritionLabelUi('단백질', '${widget.recipe.protein.split('.')[0]}g'),
        nutritionLabelUi('지방', '${widget.recipe.fat.split('.')[0]}g'),
        nutritionLabelUi('나트륨', '${widget.recipe.sodium.split('.')[0]}g'),
      ],
    );
  }

  Column nutritionLabelUi(String title, String weight) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 60,
          decoration: BoxDecoration(
              color: const Color(0xFFFEF7F5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
          alignment: Alignment.center,
          child: Text(title),
        ),
        Container(
          height: 30,
          width: 60,
          decoration: BoxDecoration(
              color: const Color(0xFFFEF7F5),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
          alignment: Alignment.center,
          child: Text(weight),
        ),
      ],
    );
  }
}

class RecipeUid {
  final Recipe recipe;
  final String uid;

  RecipeUid(this.recipe, this.uid);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeUid && other.recipe == recipe && other.uid == uid);

  @override
  int get hashCode => recipe.hashCode ^ uid.hashCode;
}
