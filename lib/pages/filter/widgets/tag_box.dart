import 'package:flutter/material.dart';

class TagBox extends StatefulWidget {
  final String text;
  final bool initiallySelected;
  final Function onRemove;
  final bool isDefault;

  TagBox({required this.text, this.initiallySelected = false, required this.onRemove, this.isDefault = false});

  @override
  _TagBoxState createState() => _TagBoxState();
}

class _TagBoxState extends State<TagBox> {
  bool isSelected = false;
  List<String> selectedFilters = [];

  void wordSelect(String filter) {
    //버튼이 선택 되었을때 리스트에 추가
    if (isSelected) {
      selectedFilters.add(filter);
    }
  }

  void wordUnselect(String filter) {
    //버튼이 선택 취소 되었을때 
    if (isSelected==false) {
      selectedFilters.removeWhere((item) => item == filter);
    }
  }

  @override
  void initState() {
    super.initState();
    isSelected = widget.initiallySelected;
  }

  bool isSelectedTag() {
    return isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          wordSelect(widget.text);
          wordUnselect(widget.text);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFCE3DD) : Colors.white,
          border: Border.all(
            color: Color(0xFFE6E6E6),
          ),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text ?? '',
              style: TextStyle(
                color: isSelected ? Color(0xFFE33811) : Color(0xFF000000),
              ),
            ),
            if (isSelected)
              Row(
                children: [
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = false;
                      });
                      if (!widget.isDefault) {
                        widget.onRemove();
                      }
                    },
                    child: Icon(Icons.close, size: 16, color: Color(0xFFE33811)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}