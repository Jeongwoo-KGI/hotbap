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
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: _isSearchComplete ? Color(0xFFF2F2F2) : Colors.white,
                border: Border.all(
                  color: _isSearchComplete ? Color(0xFFF2F2F2) : Color(0xFFCCCCCC),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _isSearchComplete
                              ? 'assets/icons/search_icon_grey.png'
                              : 'assets/icons/search_icon_white.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '재료,레시피,키워드를 검색해주세요.',
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
                            _isSearchComplete = true;
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
                        });
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
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _showCancelButton ? 12 : 0, // 패딩을 애니메이션 효과로 제거
          ),
          if (_showCancelButton)
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
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
