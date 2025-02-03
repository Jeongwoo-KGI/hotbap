import 'package:flutter/material.dart';
import 'package:hotbap/pages/login_page/join_sucess_page.dart';
import 'package:hotbap/pages/login_page/viewmodel/nick_setting_view_model.dart';

class NickSettingPage extends StatefulWidget {
  @override
  _NickSettingPageState createState() => _NickSettingPageState();
}

class _NickSettingPageState extends State<NickSettingPage> {
  late final NickSettingViewModel _viewModel; // ViewModel 인스턴스 선언

  @override
  void initState() {
    super.initState();
    _viewModel = NickSettingViewModel(); // ViewModel 초기화
  }

  @override
  void dispose() {
    _viewModel.dispose(); // ViewModel 리소스 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 화면을 터치했을 때 키보드 닫기
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white, // 단색 배경
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  '어떤 이름으로\n불러드릴까요?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
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
                  height: 8,
                ),
                SizedBox(
                  height: 56,
                  child: Center(
                    child: TextFormField(
                      controller:
                          _viewModel.nicknameController, // ViewModel의 컨트롤러 사용
                      textAlignVertical: TextAlignVertical.center, // 텍스트 높이
                      decoration: InputDecoration(
                        hintText: 'ex) 먹보의꿈',
                        hintStyle: const TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 1.35,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFCCCCCC),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFFE33811),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      cursorColor: const Color(0xFFE33811),
                      style: const TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                      inputFormatters:
                          _viewModel.nicknameInputFormatters, // 필터링 규칙 적용
                    ),
                  ),
                ),
                const Spacer(),
                // 버튼 활성화 상태를 ValueListenableBuilder로 관리
                ValueListenableBuilder<bool>(
                  valueListenable: _viewModel.isButtonEnabled,
                  builder: (context, isEnabled, child) {
                    return ElevatedButton(
                      onPressed: isEnabled
                          ? () {
                              // 페이지 이동 시 닉네임 가져오기
                              final nickname =
                                  _viewModel.nicknameController.text.trim();

                              // Navigator로 페이지 이동
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JoinSuccessPage(
                                    nickname: nickname,
                                  ),
                                ),
                              ).then((_) {
                                // 이동 후 닉네임 입력값 초기화
                                _viewModel.nicknameController.clear();
                              });
                            }
                          : null, // 버튼 비활성화
                      child: const Text(
                        '다음',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor:
                            const Color(0xFFCCCCCC), // 비활성화 상태 배경색
                        minimumSize: const Size(double.infinity, 56),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                        backgroundColor: isEnabled
                            ? const Color(0xFFE33811)
                            : const Color(0xFFCCCCCC),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 9),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
