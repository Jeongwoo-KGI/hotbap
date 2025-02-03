import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotbap/data/data_source/user_data_source.dart';
import 'package:hotbap/data/data_source/user_data_source_impl.dart';
import 'package:hotbap/data/data_source/user_remote_data_source.dart';
import 'package:hotbap/data/repository/user_repository_impl.dart';
import 'package:hotbap/domain/repository/user_repository.dart';
import 'package:hotbap/domain/usecase/fetch_user_usecase.dart';

final _userDataSourceProvider = Provider<UserDataSource> ((ref) {
  return UserDataSourceImpl();
});

final _userRemoteDataSourceProvider = Provider<UserRemoteDataSource> ((ref){
  return UserRemoteDataSourceImpl(firebaseFirestore: FirebaseFirestore.instance);
});

final _userRepositoryProvider = Provider<UserRepository>((ref) {
  final datasource = ref.read(_userDataSourceProvider);
  final remoteDataSource = ref.read(_userRemoteDataSourceProvider);
  return UserRepositoryImpl(remoteDataSource, datasource);
});

final fetchUserUsecaseProvider = Provider((ref) {
  final userRepo = ref.read(_userRepositoryProvider);
  return FetchUserUsecase(userRepo);
});