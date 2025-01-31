import 'package:hotbap/data/dto/user_dto.dart';

class User {
  final String userName;
  final String userId;
  final String seasonFilter;
  final String timeFilter;
  final List<String> ingredientFilter;

  User({required this.userName, required this.userId});

  factory User.fromDto(UserDto dto) {
    return User(
      userId: dto.userId,
      userName: dto.userName,
      seasonFilter: dto.seasonFilter,
      timeFilter: dto.timeFilter,
      ingredientFilter: dto.ingredientFilter,
    );
  }
}
