import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotbap/data/dto/user_dto.dart';

abstract class UserRemoteDataSource {
  Future<void> saveUser(String uid, UserDto user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  UserRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<void> saveUser(String uid, UserDto user) async {
    try {
      // Firebase Firestore의 'user' 컬렉션에 데이터 저장
      await firebaseFirestore.collection('user').doc(uid).set({
        'userId': uid,
        'userName': user.userName,
      });
    } catch (e) {
      print(e);
    }
  }
}
