import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotbap/firebase_options.dart';
import 'package:hotbap/theme.dart';
import 'package:hotbap/pages/profile/profile_page.dart';
import 'package:hotbap/pages/login_page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 앱 실행 시 Firebase 인증 초기화//배포할 때 삭제할것
  // await FirebaseAuth.instance.signOut();

  // ProviderScope로 앱을 감싸서 RiverPod이 ViewModel 관리할 수 있게 선언
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hot Bap',
      theme: appTheme, // 테마 파일 적용
      initialRoute: '/login', // 초기 화면을 로그인 페이지로 설정
      routes: {
        '/splash': (context) => SearchPage(), // 로그인 페이지 추가
        '/login': (context) => SearchPage(), // 로그인 페이지 추가
        '/profile': (context) => ProfilePage(), // 프로필 페이지 추가
      },
    );
  }
}
