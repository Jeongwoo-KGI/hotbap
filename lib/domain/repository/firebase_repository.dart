import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotbap/domain/usecase/sign_in_with_apple_usecase.dart';

class FirebaseRepository implements SignInWithAppleUseCase {
  final FirebaseAuth _firebaseAuth;

  FirebaseRepository(this._firebaseAuth);

  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    final nonce =
        List.generate(length, (_) => charset[random.nextInt(charset.length)])
            .join();
    print('Generated rawNonce: $nonce');
    return nonce;
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    print('Generated sha256 of rawNonce: $digest');
    return digest.toString();
  }

  @override
  Future<UserCredential> execute() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    // 애플 로그인 호출
    final appleCredential;
    //  = await S.getAppleIDCredential(
    //   scopes: [
    //     Apple
    //     AppleIDAuthorizationScopes.email,
    //     AppleIDAuthorizationScopes.fullName,
    //   ],
    //   nonce: nonce,
    // );
    // print('Apple Credential: ${appleCredential.identityToken}');

    // OAuth Credential 생성
    final oauthCredential = OAuthProvider("apple.com").credential(
      // idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Firebase 로그인
    return await _firebaseAuth.signInWithCredential(oauthCredential);
  }
}
