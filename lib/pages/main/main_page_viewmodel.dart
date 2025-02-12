import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/domain/entity/user.dart';
import 'package:hotbap/user_providers.dart';

class MainPageViewmodel extends StateNotifier<User?> {
  final Ref ref;
  StreamSubscription<User?>? _userSubscription;

  MainPageViewmodel({required this.ref}) : super(null) {_init();}

  void _init() async {
    _userSubscription?.cancel();
    _userSubscription = ref.read(fetchUserUsecaseProvider).execute().listen((user){
    //print(user);
    state = user;
    });
  }

  User? build() {
    // ref.read(fetchUserUsecaseProvider).execute().listen((user){
    //   state = user;
    // });
    return null;
  }

  Future<User?> returnUserName(String id) async {
    final state = ref.read(fetchUserUsecaseProvider).returnUserName(id);
    return state;
  }
}

final mainPageViewModel = StateNotifierProvider<MainPageViewmodel, User?>((ref){
  return MainPageViewmodel(ref: ref);
});