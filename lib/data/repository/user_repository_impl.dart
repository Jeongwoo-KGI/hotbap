import 'package:hotbap/data/data_source/user_remote_data_source.dart';
import 'package:hotbap/data/dto/user_dto.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/entity/user.dart';
import 'package:hotbap/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveUser(String uid, String userName) async {
    UserDto user = UserDto(userName: userName, userId: uid);
    await remoteDataSource.saveUser(uid, user);
  }

  @override
  Stream<User?> fetchUser() {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Future<void> addFilter(String content) {
    // TODO: implement addFilter
    throw UnimplementedError();
  }

  @override
  Future<void> addLike(Recipe recipe) {
    // TODO: implement addLike
    throw UnimplementedError();
  }

  @override
  Future<String> returnUserName() {
    // TODO: implement returnUserName
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserData(String name) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }

}
