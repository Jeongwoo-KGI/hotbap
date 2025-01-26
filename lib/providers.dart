import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/data/data_source/user_remote_data_source.dart';
import 'package:hotbap/data/repository/user_repository_impl.dart';
import 'package:hotbap/domain/usecase/save_user.dart';
import 'package:hotbap/pages/login_page/viewmodel/conditions_view_model.dart';
import 'package:hotbap/pages/login_page/viewmodel/login_viewmodel.dart';

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

// ViewModel Provider
final loginViewModelProvider = Provider<LoginViewModel>((ref) {
  final saveUserUseCase = SaveUser(
    userRepository: UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(
        firebaseFirestore: FirebaseFirestore.instance,
      ),
    ),
  );
  return LoginViewModel(saveUserUseCase: saveUserUseCase, ref: ref);
});

// ConditionsNotifier를 제공하는 Riverpod Provider
final conditionsProvider =
    StateNotifierProvider<ConditionsNotifier, ConditionsState>(
  (ref) => ConditionsNotifier(),
);
