import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/providers.dart';
import 'package:hotbap/domain/usecase/save_user.dart';

class JoinSuccessPage extends ConsumerWidget {
  final String nickname;

  JoinSuccessPage({required this.nickname});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authUidProvider); // UID 가져오기

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
      appBar: AppBar(),
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
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              Spacer(),
              Text('UID: $uid'), // UID 표시
              Text('닉네임: $nickname'),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await saveUserToFirestore();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                child: Text('완료'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
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
