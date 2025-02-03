import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/domain/entity/user.dart';
import 'package:hotbap/user_providers.dart';

class MainPageViewmodel extends StateNotifier<User?> {
  final Ref ref;
  StreamSubscription<User?>? _userSubscription;

  MainPageViewmodel({required this.ref}) : super(null) {_init();}

  void _init() {
    FirebaseAuth.FirebaseAuth.instance.authStateChanges().listen((FirebaseAuth.User? user){
      if (user != null){
        _loadUserData(user.uid);
      } else {
        _userSubscription?.cancel();
        state = null;
      }
    });
  }

  User? build() {
    ref.read(fetchUserUsecaseProvider).execute().listen((user){
      state = user;
    });
    return null;
  }

  Future<void> _loadUserData(String uid) async {
    _userSubscription?.cancel();
    _userSubscription = ref.read(fetchUserUsecaseProvider).execute().listen((user){state = user;});
  }

  Future<User?> returnUserName(String id) async {
    final state = ref.read(fetchUserUsecaseProvider).returnUserName(id);
    return state;
  }
}

final mainPageViewModel = StateNotifierProvider<MainPageViewmodel, User?>((ref){
  return MainPageViewmodel(ref: ref);
});