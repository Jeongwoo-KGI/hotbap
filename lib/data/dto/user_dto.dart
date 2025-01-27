class UserDto {
  final String userName;
  final String userId;

  UserDto({required this.userName, required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      userName: map['userName'],
      userId: map['userId'],
    );
  }
}
