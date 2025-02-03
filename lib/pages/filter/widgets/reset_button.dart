import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback onPressed;

  ResetButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFB3B3B3)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.rotate_left_outlined, color: Color(0xFF333333)),
            SizedBox(width: 8),
            Text(
              '초기화',
              style: TextStyle(
                color: Color(0xFF333333),
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