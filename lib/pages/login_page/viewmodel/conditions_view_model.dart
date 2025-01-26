import 'package:flutter_riverpod/flutter_riverpod.dart';

// 약관 상태를 관리하는 클래스
class ConditionsState {
  final bool isAllAgreed; // 모든 약관 동의 여부
  final bool isServiceAgreed; // 서비스 이용약관 동의 여부
  final bool isPrivacyAgreed; // 개인정보 처리방침 동의 여부
  final bool isAgeConfirmed; // 14세 이상 확인 여부

  ConditionsState({
    this.isAllAgreed = false,
    this.isServiceAgreed = false,
    this.isPrivacyAgreed = false,
    this.isAgeConfirmed = false,
  });

  // 현재 상태를 기반으로 일부 속성을 업데이트한 새 상태를 반환
  ConditionsState copyWith({
    bool? isAllAgreed,
    bool? isServiceAgreed,
    bool? isPrivacyAgreed,
    bool? isAgeConfirmed,
  }) {
    return ConditionsState(
      isAllAgreed: isAllAgreed ?? this.isAllAgreed,
      isServiceAgreed: isServiceAgreed ?? this.isServiceAgreed,
      isPrivacyAgreed: isPrivacyAgreed ?? this.isPrivacyAgreed,
      isAgeConfirmed: isAgeConfirmed ?? this.isAgeConfirmed,
    );
  }
}

// 약관 상태를 관리하는 Notifier
class ConditionsNotifier extends StateNotifier<ConditionsState> {
  ConditionsNotifier() : super(ConditionsState());

  // 모든 약관 동의 상태를 변경
  void toggleAllAgreements(bool value) {
    state = state.copyWith(
      isAllAgreed: value,
      isServiceAgreed: value,
      isPrivacyAgreed: value,
      isAgeConfirmed: value,
    );
  }

  // 서비스 이용약관 동의 상태를 변경
  void toggleServiceAgreement(bool value) {
    state = state.copyWith(
      isServiceAgreed: value,
      isAllAgreed: value && state.isPrivacyAgreed && state.isAgeConfirmed,
    );
  }

  // 개인정보 처리방침 동의 상태를 변경
  void togglePrivacyAgreement(bool value) {
    state = state.copyWith(
      isPrivacyAgreed: value,
      isAllAgreed: value && state.isServiceAgreed && state.isAgeConfirmed,
    );
  }

  // 14세 이상 확인 상태를 변경
  void toggleAgeConfirmation(bool value) {
    state = state.copyWith(
      isAgeConfirmed: value,
      isAllAgreed: value && state.isServiceAgreed && state.isPrivacyAgreed,
    );
  }
}
