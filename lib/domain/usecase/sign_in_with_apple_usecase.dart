import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInWithAppleUseCase {
  Future<UserCredential> execute();
}
