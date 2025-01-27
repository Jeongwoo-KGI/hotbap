import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// 닉네임 설정 상태를 관리하는 ViewModel
class NickSettingViewModel {
  final TextEditingController nicknameController; // 닉네임 입력 필드 컨트롤러
  final ValueNotifier<bool> isButtonEnabled; // 버튼 활성화 여부를 감지하는 ValueNotifier

  NickSettingViewModel()
      : nicknameController = TextEditingController(),
        isButtonEnabled = ValueNotifier(false) {
    // 컨트롤러에 리스너 추가
    nicknameController.addListener(() {
      final isNotEmpty = nicknameController.text.trim().isNotEmpty;
      isButtonEnabled.value = isNotEmpty; // 입력값 유무에 따라 버튼 활성화 상태 변경
    });
  }

  /// 닉네임 컨트롤러와 ValueNotifier를 해제
  void dispose() {
    nicknameController.dispose();
    isButtonEnabled.dispose();
  }

  /// 닉네임 입력값에 대한 필터링 규칙 반환
  List<TextInputFormatter> get nicknameInputFormatters {
    return [
      FilteringTextInputFormatter.allow(
        RegExp(r'[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣㆍ]'), // 영어 및 한글만 허용
      ),
    ];
  }
}
