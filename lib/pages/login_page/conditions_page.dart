import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotbap/pages/login_page/nick_setting_page.dart';
import 'package:hotbap/providers.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ConditionsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태와 상태 관리 객체 가져오기
    final conditionsState = ref.watch(conditionsProvider);
    final conditionsNotifier = ref.read(conditionsProvider.notifier);

    return Scaffold(
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
              const SizedBox(height: 20),
              const Text(
                '이용약관',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 24,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 20),
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
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              const SizedBox(height: 44.5),
              // 모두 동의하기
              _buildCustomCheckboxTileAll(
                value: conditionsState.isAllAgreed,
                onChanged: (value) {
                  conditionsNotifier.toggleAllAgreements(value ?? false);
                },
              ),
              const SizedBox(height: 33),
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
              const SizedBox(height: 28),
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
              const SizedBox(height: 27),
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
              // 동의가 완료되면 다음 버튼 활성화
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
                  minimumSize: const Size(double.infinity, 56),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                  backgroundColor: const Color(0xFFE33811), // 활성화 상태 배경색
                  foregroundColor: Colors.white, // 활성화 상태 글씨 색
                  disabledBackgroundColor:
                      const Color(0xFFCCCCCC), // 비활성화 상태 배경색
                  disabledForegroundColor: Colors.white, // 비활성화 상태 글씨 색
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
          SizedBox(
            child: SvgPicture.asset(
              value
                  ? 'assets/icons/svg/check.svg'
                  : 'assets/icons/svg/check_default.svg',
              width: 20,
              height: 20,
              colorFilter: value
                  ? ColorFilter.mode(Color(0xFFF05937), BlendMode.srcIn)
                  : ColorFilter.mode(Color(0xFFCCCCCC), BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  if (label.startsWith('(필수)'))
                    const TextSpan(
                      text: '(필수) ',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Color(0xFFF05937),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  TextSpan(
                    text: label.replaceFirst('(필수)', ''),
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
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
              child: SizedBox(
                child: SvgPicture.asset(
                  'assets/icons/svg/arrow_s_right.svg',
                  width: 24,
                  height: 24,
                  colorFilter:
                      ColorFilter.mode(Color(0xFF999999), BlendMode.srcIn),
                ),
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
          SizedBox(
            child: SvgPicture.asset(
              value
                  ? 'assets/icons/svg/chechmark_selected.svg'
                  : 'assets/icons/svg/chechmark_default.svg',
              width: 24,
              height: 24,
              colorFilter: value
                  ? ColorFilter.mode(Color(0xFFF05937), BlendMode.srcIn)
                  : ColorFilter.mode(Color(0xFFCCCCCC), BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 8),
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
