import 'package:flutter/material.dart';

class SearchResultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String resultText;

  SearchResultButton({required this.onPressed, required this.resultText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 218,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 14),
        decoration: ShapeDecoration(
          color: Color(0xFFE33811),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              resultText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}