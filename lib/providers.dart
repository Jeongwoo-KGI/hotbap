import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotbap/domain/repository/firebase_repository.dart';
import 'package:hotbap/domain/usecase/sign_in_with_apple_usecase.dart';
import 'package:hotbap/pages/login_page/viewmodel/login_viewmodel.dart';

// FirebaseAuth Provider
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// SignInWithAppleUseCase Provider
final signInWithAppleUseCaseProvider = Provider<SignInWithAppleUseCase>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return FirebaseRepository(firebaseAuth);
});

// LoginViewModel Provider
// Riverpod provider 선언
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, User?>((ref) {
  final signInWithAppleUseCase = ref.watch(signInWithAppleUseCaseProvider);
  return LoginViewModel(signInWithAppleUseCase);
});
