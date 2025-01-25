import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotbap/data/data_source/exceptions.dart';
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
      await firebaseFirestore.collection('users').doc(uid).set({
        'userId': uid,
        'userName': user.userName,
      });
    } catch (e) {
      throw FirebaseExceptionCustom('Failed to save user data: $e');
    }
  }
}
