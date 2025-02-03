import 'package:flutter/material.dart';

class TagBox extends StatefulWidget {
  final String text;
  final bool initiallySelected;
  final Function onRemove;

  TagBox({required this.text, this.initiallySelected = false, required this.onRemove});

  @override
  _TagBoxState createState() => _TagBoxState();
}

class _TagBoxState extends State<TagBox> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initiallySelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFCE3DD) : Colors.white,
          border: Border.all(
            color: isSelected ? Color(0xFFE33811) : Color(0xFFE6E6E6),
          ),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: isSelected ? Color(0xFFE33811) : Color(0xFF000000),
              ),
            ),
            if (isSelected)
              IconButton(
                icon: Icon(Icons.close, size: 16, color: Color(0xFFE33811)),
                onPressed: () {
                  setState(() {
                    isSelected = false;
                  });
                  widget.onRemove();
                },
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}