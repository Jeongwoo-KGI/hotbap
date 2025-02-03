import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Function(String) onSubmitted;

  InputBox({required this.controller, required this.label, required this.onSubmitted});

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8), // 여백 수정
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.60,
            color: _focusNode.hasFocus ? Color(0xFFE33811) : Color(0xFFCCCCCC),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Color(0xFF7F7F7F)), // 돋보기 아이콘 추가
          SizedBox(width: 8), // 아이콘과 텍스트 필드 사이의 간격 추가
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              textAlignVertical: TextAlignVertical.center, // 텍스트 중앙 정렬
              cursorColor: Color(0xFFE33811), // 커서 색상 지정
              decoration: InputDecoration(
                labelText: _focusNode.hasFocus ? '' : widget.label,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12), // 패딩 추가하여 중앙 정렬
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  widget.onSubmitted(value);
                  widget.controller.clear();
                }
              },
              style: TextStyle(
                color: Color(0xFF7F7F7F),
                fontSize: 16,
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