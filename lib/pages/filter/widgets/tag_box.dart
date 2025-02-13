import 'package:flutter/material.dart';
import 'package:hotbap/pages/filter/filter_selected_list.dart';
class TagBox extends StatelessWidget {
  const TagBox({super.key, required this.onSelected, required this.isSelected, required this.text, required this.onRemove, required this.isDefault, });
  final bool isSelected;
  final String text;
  final Function onRemove;
  final bool isDefault;
  final Function onSelected;

  @override
  Widget build(BuildContext context) {
        return GestureDetector(
      onTap: () {
          onSelected(text);
          //print(filterSelectedList);
        
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
              text ?? '',
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
                      
                      if (!isDefault) {
                        onRemove();
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
