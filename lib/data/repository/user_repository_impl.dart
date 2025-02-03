import 'package:hotbap/data/data_source/user_data_source.dart';
import 'package:hotbap/data/data_source/user_remote_data_source.dart';
import 'package:hotbap/data/dto/user_dto.dart';
import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/entity/user.dart';
import 'package:hotbap/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this.remoteDataSource, this._userDataSource);

  @override
  Future<void> saveUser(String uid, String userName) async {
    UserDto user = UserDto(userName: userName, userId: uid);
    await remoteDataSource.saveUser(uid, user);
  }

  @override
  Stream<User?> fetchUser() {
    return _userDataSource.fetchUser().map((userDto) {
      //UserDto -> User
      return userDto == null ? null : User.fromDto(userDto);
    });
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
  Future<User?> returnUserName(String id) async {
    try {
      final result = await _userDataSource.returnUserName(id);
      if (result != null) {
        return User.fromDto(result);
      } else {
        throw Exception('no user found with id: $id');
      }
    } catch (e) {
      throw Exception('failed to fetch user $e');
    }
  }

  @override
  Future<void> updateUserData(String name)async {
    try {
      await _userDataSource.updateUserData(name);
    } catch(e) {
      throw Exception('Failed to update user data');
    }
  }

}
