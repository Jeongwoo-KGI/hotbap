import 'package:hotbap/domain/entity/recipe.dart';
import 'package:hotbap/domain/entity/user.dart';

abstract class UserRepository {
  Future<void> saveUser(String uid, String userName);
  Stream<User?> fetchUser();
  Future<String> returnUserName(String id);
  Future<void> addLike(Recipe recipe);
  Future<void> addFilter(String content);
  Future<void> updateUserData(String name);
}
