import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotbap/pages/containter_page.dart/container_page.dart';
import 'package:hotbap/pages/login_page/conditions_page.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/providers.dart';
import 'package:hotbap/domain/usecase/save_user.dart';

class JoinSuccessPage extends ConsumerWidget {
  final String nickname;
  User? user;

  JoinSuccessPage({required this.nickname});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user = FirebaseAuth.instance.currentUser;

    final uid = user!.uid; // UID 가져오기

    // SaveUser를 가져오기
    final saveUserUseCase = ref.watch(loginViewModelProvider).saveUserUseCase;
    Future<void> saveUserToFirestore() async {
      if (uid != null && nickname.isNotEmpty) {
        try {
          await saveUserUseCase
              .call(SaveUserParams(uid: uid, userName: nickname));
          print('User saved to Firestore: UID: $uid, Name: $nickname');
        } catch (e) {
          print('Error saving user data: $e');
        }
      } else {
        print('UID or nickname is null');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white, // 단색 배경
          ),
        ),
        leading: IconButton(
          icon: SizedBox(
            child: SvgPicture.asset(
              'assets/icons/svg/arrow_m_left.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Color(0xFF333333), BlendMode.srcIn),
            ),
          ),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가는 동작
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                'HOT밥에\n오신 걸 환영해요!',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 24,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/logo_sucess.svg', // SVG 이미지 경로
                    width: 164.3,
                    height: 198,
                  ),
                ),
              ),
              SizedBox(
                height: 69,
              ),
              ElevatedButton(
                onPressed: () async {
                  await saveUserToFirestore();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ContainerPage()),
                    (route) => false, // 모든 기존 스택 제거
                  );
                },
                child: Text('완료'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                  backgroundColor: Color(0xFFE33811),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 9),
            ],
          ),
        ),
      ),
    );
  }
}
