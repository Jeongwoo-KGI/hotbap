import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotbap/application/viewmodels/recipe_viewmodel.dart';

class SearchWidget extends StatefulWidget {
  final Function(String) onSearchSubmitted;
  final Function onCancelSearch;

  SearchWidget({required this.onSearchSubmitted, required this.onCancelSearch});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _showCancelButton = false;
  bool _showClearButton = false;
  bool _isSearchComplete = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _showCancelButton ? 302 : 335,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: _isSearchComplete ? Color(0xFFF2F2F2) : Colors.white, // 색상 변경
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
                    onChanged: (text) {
                      setState(() {
                        _showCancelButton = true;
                        _showClearButton = text.isNotEmpty;
                        _isSearchComplete = false;
                      });
                    },
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        Provider.of<RecipeViewModel>(context, listen: false).searchRecipes(query);
                        widget.onSearchSubmitted(query);
                        setState(() {
                          _showClearButton = true;
                          _isSearchComplete = true; // 검색 완료 시 상태 변경
                        });
                      }
                    },
                  ),
                ),
                if (_showClearButton)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.clear();
                        _showClearButton = false;
                        _isSearchComplete = false;
                      });
                      widget.onCancelSearch();
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/clear_icon.png'), 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 12),
          if (_showCancelButton)
            TextButton(
              onPressed: () {
                setState(() {
                  _controller.clear();
                  _showCancelButton = false;
                  _showClearButton = false;
                  _isSearchComplete = false;
                });
                widget.onCancelSearch();
                FocusScope.of(context).unfocus();
              },
              child: Text(
                '취소',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
