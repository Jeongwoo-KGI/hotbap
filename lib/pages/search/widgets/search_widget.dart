import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotbap/application/viewmodels/recipe_viewmodel.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final Function(String) onSearchSubmitted;

  SearchWidget({required this.onSearchSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search, color: Color(0xFFB3B3B3)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '검색',
                hintStyle: TextStyle(
                  color: Color(0xFFB3B3B3),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              textAlignVertical: TextAlignVertical.center,
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  Provider.of<RecipeViewModel>(context, listen: false).searchRecipes(query);
                  onSearchSubmitted(query); // 입력된 검색어 전달
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
