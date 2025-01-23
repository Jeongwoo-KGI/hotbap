import 'package:flutter/material.dart';

class ConditionsPage extends StatefulWidget {
  @override
  _ConditionsPageState createState() => _ConditionsPageState();
}

class _ConditionsPageState extends State<ConditionsPage> {
  // 체크박스 상태 관리
  bool _isAllAgreed = false; // 모두 동의하기
  bool _isServiceAgreed = false; // 서비스 이용약관 동의
  bool _isPrivacyAgreed = false; // 개인정보처리방침 동의
  bool _isAgeConfirmed = false; // 14세 이상 확인

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 24,
              ),
              Text(
                '이용약관',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Pretendard',
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
                  color: Color(0xFFF2F2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
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
              const SizedBox(height: 20),
              // 모두 동의하기
              _buildCustomCheckboxTileAll(
                value: _isAllAgreed,
                onChanged: (bool? value) {
                  setState(() {
                    _isAllAgreed = value ?? false;
                    _isServiceAgreed = _isAllAgreed;
                    _isPrivacyAgreed = _isAllAgreed;
                    _isAgeConfirmed = _isAllAgreed;
                  });
                },
              ),
              // (필수) 서비스 이용약관
              _buildCustomCheckboxTile(
                label: '(필수) 서비스 이용약관',
                value: _isServiceAgreed,
                onChanged: (bool? value) {
                  setState(() {
                    _isServiceAgreed = value ?? false;
                    _updateAllAgreedState();
                  });
                },
              ),
              // (필수) 개인정보처리방침
              _buildCustomCheckboxTile(
                label: '(필수) 개인정보 처리방침',
                value: _isPrivacyAgreed,
                onChanged: (bool? value) {
                  setState(() {
                    _isPrivacyAgreed = value ?? false;
                    _updateAllAgreedState();
                  });
                },
              ),
              // (필수) 14세 이상 확인
              _buildCustomCheckboxTile(
                label: '(필수) 14세 이상이에요',
                value: _isAgeConfirmed,
                onChanged: (bool? value) {
                  setState(() {
                    _isAgeConfirmed = value ?? false;
                    _updateAllAgreedState();
                  });
                },
              ),
              const Spacer(),
              // 모두 동의 시 버튼 활성화
              ElevatedButton(
                onPressed:
                    (_isServiceAgreed && _isPrivacyAgreed && _isAgeConfirmed)
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('모든 약관에 동의하셨습니다!')),
                            );
                          }
                        : null, // 동의하지 않으면 버튼 비활성화
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
    );
  }

  // "모두 동의하기" 상태 업데이트
  void _updateAllAgreedState() {
    setState(() {
      _isAllAgreed = _isServiceAgreed && _isPrivacyAgreed && _isAgeConfirmed;
    });
  }

  // 커스텀 체크박스 Tile
  Widget _buildCustomCheckboxTile({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: [
          // 체크박스
          Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: null,
                borderRadius: BorderRadius.circular(20),
              ),
              child: value
                  ? Icon(Icons.check, color: Color(0xFFE33811), size: 18)
                  : Icon(Icons.check, color: Colors.grey[200], size: 18)),
          // 라벨
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  // "(필수)" 부분에만 스타일 적용
                  if (label.startsWith('(필수)'))
                    TextSpan(
                      text: '(필수) ',
                      style: TextStyle(
                        color: Color(0xFFF05937),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  // 나머지 텍스트
                  TextSpan(
                    text: label.replaceFirst('(필수)', ''), // "(필수)" 제외한 텍스트
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
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
          // 체크박스
          Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: value ? Color(0xFFE33811) : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.check, color: Colors.white, size: 18)),
          // 라벨
          Expanded(
            child: Text(
              '모두 동의하기',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'Pretendard',
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
