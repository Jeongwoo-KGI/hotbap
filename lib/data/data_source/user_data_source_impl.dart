import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotbap/data/data_source/user_data_source.dart';
import 'package:hotbap/data/dto/user_dto.dart';
import 'package:hotbap/domain/entity/recipe.dart';

class UserDataSourceImpl implements UserDataSource{

  @override
  Stream<UserDto?> fetchUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if(user == null) {
        throw Exception('user is not yet signed in');
      }

      final firestore = FirebaseFirestore.instance;
      final collection = firestore.collection('user');
      final query = collection.doc(user.uid);

      return query.snapshots().map((snapshot) {
        if (snapshot.exists) {
          return UserDto.fromMap(snapshot.data()!);
        }
        return null;

      });

    } catch (e) {
      throw Exception('No user found with uid $e');
    }
  }

  @override
  Future<void> addLike(Recipe recipe) {
    // TODO: implement addLike
    throw UnimplementedError();
  }

  @override
  Future<void> addFilter(String content) {
    // TODO: implement addFilter
    throw UnimplementedError();
  }

  @override
  Future<String> returnUserName(String id) async {
    try {
      final firestore = await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .get();
        final map = firestore.data() as Map<String, dynamic>;
        return map['userName'];
    } catch (e) {
      throw Exception('return failed $e');
    }
  }

  @override
  Future<void> updateUserData(String name) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('empty function usage');
      };

      //update user data
      await firestore.collection('user').doc(user.uid).update({
        'name': name,
      });
      //String successMessage = 'Upload successful';
      //print(successMessage);
    } catch (e) {
      throw Exception('user data upload failed. Error: $e');
    }
  }
}