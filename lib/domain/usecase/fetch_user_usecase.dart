import 'package:hotbap/domain/entity/user.dart';
import 'package:hotbap/domain/repository/user_repository.dart';

class FetchUserUsecase {
  final UserRepository _userRepository;
  FetchUserUsecase(this._userRepository);

  Stream<User?> execute() {
    return _userRepository.fetchUser();
  }

  Future<User?> returnUserName(String id) async {
    return _userRepository.returnUserName(id);
  }
}