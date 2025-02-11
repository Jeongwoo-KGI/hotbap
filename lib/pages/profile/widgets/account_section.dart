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
            width: widget.screenWidth,
            padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.025),
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
          SizedBox(height: widget.screenHeight * 0.02), // 비율에 맞춘 간격
          Container(
            width: widget.screenWidth * 0.9,
            height: widget.screenHeight * 0.05,
            padding: EdgeInsets.only(left: widget.screenWidth * 0.025), // 왼쪽에 비율에 맞춘 여백 추가
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
                          fontSize: widget.screenWidth * 0.035,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                SizedBox(width: widget.screenWidth * 0.64), // 텍스트와 아이콘 사이 간격을 비율로 설정
                SizedBox(
                  width: widget.screenWidth * 0.06,
                  height: widget.screenWidth * 0.06,
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