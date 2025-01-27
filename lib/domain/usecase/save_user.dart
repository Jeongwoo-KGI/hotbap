import 'package:hotbap/domain/repository/user_repository.dart';
import 'package:hotbap/domain/usecase/join_usecase.dart';

class SaveUser implements JoinUseCase<void, SaveUserParams> {
  final UserRepository userRepository;

  SaveUser({required this.userRepository});

  @override
  Future<void> call(SaveUserParams params) async {
    return await userRepository.saveUser(params.uid, params.userName);
  }
}

class SaveUserParams {
  final String uid;
  final String userName;

  SaveUserParams({required this.uid, required this.userName});
}
