import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotbap/pages/profile/widgets/guest_dialog.dart';

class AccountSection extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final TextEditingController nameController;
  final VoidCallback saveUserName;
  final bool userGuest;

  AccountSection(this.screenWidth, this.screenHeight,
      {required this.nameController,
      required this.saveUserName,
      required this.userGuest});
  @override
  _AccountSectionState createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  bool isEditing = false;

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.userGuest) {
          showNoSavedRecipesDialog(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '내 계정',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: widget.screenWidth * 0.04,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 375,
            height: 40,
            padding: const EdgeInsets.only(left: 10), // 왼쪽에만 20 여백 추가
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isEditing
                    ? Expanded(
                        child: TextField(
                          controller: widget.nameController,
                          decoration: InputDecoration(hintText: '닉네임 입력'),
                        ),
                      )
                    : Text(
                        '닉네임 수정',
                        style: TextStyle(
                          color: Color(0xFF4D4D4D),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                SizedBox(width: 240), // 텍스트와 아이콘 사이 간격을 253으로 설정
                SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      isEditing
                          ? 'assets/icons/svg/check.svg'
                          : 'assets/icons/svg/arrow_s_right.svg', // 수정된 아이콘 경로
                    ),
                    onPressed: () {
                      if (widget.userGuest) {
                        showNoSavedRecipesDialog(context);
                      } else if (isEditing) {
                        widget.saveUserName();
                      }
                      toggleEditing();
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
