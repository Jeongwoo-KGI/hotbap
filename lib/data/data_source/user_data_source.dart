import 'package:hotbap/data/dto/user_dto.dart';
import 'package:hotbap/domain/entity/recipe.dart';

abstract interface class UserDataSource {
  Stream<UserDto?> fetchUser();

  Future<void> addLike(Recipe recipe);
  Future<void> addFilter(String content);
  Future<void> updateUserData(String name); //add contents if required
  Future<String> returnUserName(String id); //FixMe: fix me to UserDto


}