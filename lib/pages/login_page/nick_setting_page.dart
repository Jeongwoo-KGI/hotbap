import 'package:flutter/material.dart';

class NickSettingPage extends StatefulWidget {
  @override
  _NickSettingPageState createState() => _NickSettingPageState();
}

class _NickSettingPageState extends State<NickSettingPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final FocusNode _nicknameFocusNode = FocusNode();

  @override
  void dispose() {
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        // TextFormField 외부를 클릭하면 키보드 및 FocusNode 해제
        onTap: () {
          if (_nicknameFocusNode.hasFocus) {
            _nicknameFocusNode.unfocus();
          }
        },
        child: SafeArea(
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
                      focusNode: _nicknameFocusNode,
                      textAlignVertical: TextAlignVertical.center,
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
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE33811)),
                        ),
                      ),
                      cursorColor: Color(0xFFE33811),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // 페이지 이동 시 컨트롤러 내용 초기화
                    _nicknameController.clear();

                    // Navigator로 페이지 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnotherPage()),
                    );
                  },
                  child: Text('다음'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('다음 페이지')),
    );
  }
}
