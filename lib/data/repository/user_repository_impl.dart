import 'package:hotbap/data/data_source/user_remote_data_source.dart';
import 'package:hotbap/data/dto/user_dto.dart';
import 'package:hotbap/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveUser(String uid, String userName) async {
    UserDto user = UserDto(userName: userName, userId: uid);
    await remoteDataSource.saveUser(uid, user);
  }
}
