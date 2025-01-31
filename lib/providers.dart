import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/data/data_source/user_remote_data_source.dart';
import 'package:hotbap/data/repository/favorite_repository_impl.dart';
import 'package:hotbap/data/repository/user_repository_impl.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/repository/favorite_repository.dart';
import 'package:hotbap/domain/usecase/save_user.dart';
import 'package:hotbap/domain/usecase/toggle_favorite_usecase.dart';
import 'package:hotbap/pages/detail_page/detail_page.dart';
import 'package:hotbap/pages/login_page/viewmodel/conditions_view_model.dart';
import 'package:hotbap/pages/login_page/viewmodel/login_viewmodel.dart';

// Firebase 인증 상태를 감시하는 StreamProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
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

// 즐겨찾기 상태를 관리하는 Provider
final favoriteProvider =
    StateNotifierProvider.family<FavoriteNotifier, bool, RecipeUid>(
  (ref, params) {
    final recipe = params.recipe;
    final uid = params.uid;

    final toggleFavoriteUseCase = ref.read(toggleFavoriteUseCaseProvider);
    return FavoriteNotifier(ref, uid, recipe, toggleFavoriteUseCase);
  },
);

// FavoriteRepository Provider
final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepositoryImpl(firebaseFirestore: FirebaseFirestore.instance);
});

// ToggleFavoriteUseCase Provider
final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>((ref) {
  final repository = ref.read(favoriteRepositoryProvider);
  return ToggleFavoriteUseCase(repository);
});

class FavoriteNotifier extends StateNotifier<bool> {
  final String? userId; // userId를 nullable로 유지
  final Recipe recipe;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  // FavoriteNotifier의 생성자에서 StateNotifierProviderRef를 받습니다.
  FavoriteNotifier(StateNotifierProviderRef ref, this.userId, this.recipe,
      this.toggleFavoriteUseCase)
      : super(false) {
    _checkFavorite();
  }

  // 사용자 정보가 있을 경우, 해당 레시피가 즐겨찾기인지 체크
  Future<void> _checkFavorite() async {
    if (userId == null) return; // userId가 null이면 아무 작업도 하지 않음
    state = await toggleFavoriteUseCase.repository
        .isFavorite(userId!, recipe.title); // 레시피가 즐겨찾기인지 확인
  }

  // 즐겨찾기 상태 토글
  Future<void> toggleFavorite() async {
    print('111111111$userId');
    if (userId == null) return; // userId가 null이면 아무 작업도 하지 않음
    state = await toggleFavoriteUseCase.execute(userId!, recipe); // 즐겨찾기 추가/삭제
  }
}
