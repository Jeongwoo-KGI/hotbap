import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Firebase 인증 상태를 감시하는 StreamProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// UID 상태를 관리하는 StateNotifier
class AuthUidNotifier extends StateNotifier<String?> {
  AuthUidNotifier() : super(null);

  void setUid(String? uid) {
    state = uid;
  }
}

// UID 상태를 관리하는 Provider
final authUidProvider = StateNotifierProvider<AuthUidNotifier, String?>((ref) {
  return AuthUidNotifier();
});
