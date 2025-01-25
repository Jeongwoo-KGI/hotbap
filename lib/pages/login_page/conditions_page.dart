import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/pages/login_page/nick_setting_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 상태 관리용 StateNotifier
class ConditionsState {
  final bool isAllAgreed;
  final bool isServiceAgreed;
  final bool isPrivacyAgreed;
  final bool isAgeConfirmed;

  ConditionsState({
    this.isAllAgreed = false,
    this.isServiceAgreed = false,
    this.isPrivacyAgreed = false,
    this.isAgeConfirmed = false,
  });

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

class ConditionsNotifier extends StateNotifier<ConditionsState> {
  ConditionsNotifier() : super(ConditionsState());

  void toggleAllAgreements(bool value) {
    state = state.copyWith(
      isAllAgreed: value,
      isServiceAgreed: value,
      isPrivacyAgreed: value,
      isAgeConfirmed: value,
    );
  }

  void toggleServiceAgreement(bool value) {
    state = state.copyWith(
      isServiceAgreed: value,
      isAllAgreed: value && state.isPrivacyAgreed && state.isAgeConfirmed,
    );
  }

  void togglePrivacyAgreement(bool value) {
    state = state.copyWith(
      isPrivacyAgreed: value,
      isAllAgreed: value && state.isServiceAgreed && state.isAgeConfirmed,
    );
  }

  void toggleAgeConfirmation(bool value) {
    state = state.copyWith(
      isAgeConfirmed: value,
      isAllAgreed: value && state.isServiceAgreed && state.isPrivacyAgreed,
    );
  }
}

// 리버팟 Provider
final conditionsProvider =
    StateNotifierProvider<ConditionsNotifier, ConditionsState>(
  (ref) => ConditionsNotifier(),
);

class ConditionsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conditionsState = ref.watch(conditionsProvider);
    final conditionsNotifier = ref.read(conditionsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                '이용약관',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF2F2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '핫밥의 서비스 약관이에요.\n필수 약관을 동의하셔야 이용할 수 있어요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF656565),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 모두 동의하기
              _buildCustomCheckboxTileAll(
                value: conditionsState.isAllAgreed,
                onChanged: (value) {
                  conditionsNotifier.toggleAllAgreements(value ?? false);
                },
              ),
              const SizedBox(height: 16),
              // (필수) 서비스 이용약관
              _buildCustomCheckboxTile(
                label: '(필수) 서비스 이용약관',
                value: conditionsState.isServiceAgreed,
                link: 'https://tutle02.tistory.com/60',
                arrowIcon: true,
                onChanged: (value) {
                  conditionsNotifier.toggleServiceAgreement(value ?? false);
                },
              ),
              const SizedBox(height: 12),
              // (필수) 개인정보처리방침
              _buildCustomCheckboxTile(
                label: '(필수) 개인정보 처리방침',
                value: conditionsState.isPrivacyAgreed,
                link: 'https://tutle02.tistory.com/61',
                arrowIcon: true,
                onChanged: (value) {
                  conditionsNotifier.togglePrivacyAgreement(value ?? false);
                },
              ),
              const SizedBox(height: 12),
              // (필수) 14세 이상 확인
              _buildCustomCheckboxTile(
                label: '(필수) 14세 이상이에요',
                value: conditionsState.isAgeConfirmed,
                link: '',
                arrowIcon: false,
                onChanged: (value) {
                  conditionsNotifier.toggleAgeConfirmation(value ?? false);
                },
              ),
              const Spacer(),
              // 모두 동의 시 버튼 활성화
              ElevatedButton(
                onPressed: (conditionsState.isServiceAgreed &&
                        conditionsState.isPrivacyAgreed &&
                        conditionsState.isAgeConfirmed)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NickSettingPage(),
                          ),
                        );
                      }
                    : null,
                child: const Text('다음'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                  backgroundColor: const Color(0xFFE33811),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 9),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomCheckboxTile({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required bool arrowIcon,
    required String link,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: [
          Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 12),
              child: value
                  ? const Icon(Icons.check, color: Color(0xFFE33811), size: 18)
                  : Icon(Icons.check, color: Colors.grey[200], size: 18)),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  if (label.startsWith('(필수)'))
                    const TextSpan(
                      text: '(필수) ',
                      style: TextStyle(
                        color: Color(0xFFF05937),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  TextSpan(
                    text: label.replaceFirst('(필수)', ''),
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (arrowIcon)
            GestureDetector(
              onTap: () async {
                await launchUrlString(link);
              },
              child: Icon(
                Icons.arrow_forward_ios,
                size: 17,
                color: Colors.grey[400],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomCheckboxTileAll({
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: [
          Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: value ? const Color(0xFFE33811) : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 18)),
          const Expanded(
            child: Text(
              '모두 동의하기',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
