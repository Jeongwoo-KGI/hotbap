import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotbap/pages/login_page/join_sucess_page.dart';

class NickSettingPage extends StatefulWidget {
  @override
  _NickSettingPageState createState() => _NickSettingPageState();
}

class _NickSettingPageState extends State<NickSettingPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    // 입력값 변화 감지
    _nicknameController.addListener(() {
      final isNotEmpty = _nicknameController.text.trim().isNotEmpty;
      _isButtonEnabled.value = isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Text(
                  '어떤 이름으로\n불러드릴까요?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  '닉네임',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: Center(
                    child: TextFormField(
                      controller: _nicknameController,
                      textAlignVertical: TextAlignVertical.bottom, //텍스트 높이
                      decoration: InputDecoration(
                        hintText: 'ex) 먹보의꿈',
                        hintStyle: TextStyle(
                          color: Color(0xFFCCCCCC),
                          fontSize: 16,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFCCCCCC),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFE33811),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      cursorColor: Color(0xFFE33811),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣㆍ]'), // 영문, 한글 포함
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                ValueListenableBuilder<bool>(
                  valueListenable: _isButtonEnabled,
                  builder: (context, isEnabled, child) {
                    return ElevatedButton(
                      onPressed: isEnabled
                          ? () {
                              // 페이지 이동 시 컨트롤러 내용 초기화 없이 이동
                              final nickname = _nicknameController.text.trim();

                              // Navigator로 페이지 이동
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JoinSuccessPage(
                                    nickname: nickname,
                                  ),
                                ),
                              ).then((_) {
                                // 페이지 이동 후 컨트롤러 초기화
                                _nicknameController.clear();
                              });
                            }
                          : null, // 버튼 비활성화
                      child: Text('다음'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 56),
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                        backgroundColor:
                            isEnabled ? Color(0xFFE33811) : Color(0xFFCCCCCC),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 9),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
