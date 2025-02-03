import 'package:flutter/material.dart';

class AccountSection extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final TextEditingController nameController;
  final VoidCallback saveUserName;

  AccountSection(this.screenWidth, this.screenHeight,
      {required this.nameController, required this.saveUserName});
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
    return Column(
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
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                      ),
                    ),
              SizedBox(
                width: 9.5,
                height: 17.48,
                child: IconButton(
                  icon: Icon(
                    isEditing ? Icons.check : Icons.arrow_forward_ios,
                    color: Color(0xFF333333),
                  ),
                  onPressed: () {
                    if (isEditing) {
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
    );
  }
}
