import 'package:hotbap/domain/entity/ingredientFilterDefault.dart';

class UserDto {
  final String userName;
  final String userId;
  final String seasonFilter;
  final String timeFilter;
  final List<String> ingredientFilter;
  final List<String>ingredientFilterdefault = ingredientFilterDefault();

  UserDto({required this.userName, required this.userId, this.seasonFilter = "", this.ingredientFilter = const [], this.timeFilter = ""}); //add ingredientFilter elements when necessary 

  Map<String, dynamic> toMap() {
    if (ingredientFilter.isEmpty) {
      return {
        'userName': userName,
        'seasonFilter':seasonFilter,
        'timeFilter' : timeFilter,
        'ingredientFilter':ingredientFilterdefault,
      };
    } else {
    return {
      'userName': userName,
      'seasonFilter': seasonFilter,
      'timeFilter' : timeFilter,
      'ingredientFilter' : ingredientFilter,
    };
    }
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      userName: map['userName'],
      userId: map['userId'],
      seasonFilter: map['seasonFilter'],
      timeFilter: map['timeFilter'],
      ingredientFilter: map['ingredientFilter'],
    );
  }
}
