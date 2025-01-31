class UserDto {
  final String userName;
  final String userId;
  final String seasonFilter;
  final String timeFilter;
  final List<String> ingredientFilter;

  UserDto({required this.userName, required this.userId, this.seasonFilter = "", this.ingredientFilter = const ["감자", "돼지고기"], this.timeFilter = ""}); //add ingredientFilter elements when necessary 

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'seasonFilter': seasonFilter,
      'timeFilter' : timeFilter,
      'ingredientFilter' : ingredientFilter,
    };
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
