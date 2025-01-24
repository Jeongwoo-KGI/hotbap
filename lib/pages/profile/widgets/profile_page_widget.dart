import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotbap/pages/profile/widgets/profile_user_name.dart';
import 'package:hotbap/pages/profile/widgets/saved_recipes.dart';
import 'package:hotbap/pages/profile/widgets/account_section.dart';
import 'package:hotbap/pages/profile/widgets/account_management.dart';
import 'package:hotbap/pages/profile/widgets/support_section.dart';
import 'package:hotbap/pages/savedrecipes/saved_recipes_page.dart'; // 찜리스트 페이지 임포트

class ProfilePageWidget extends StatefulWidget {
  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  final TextEditingController _nameController = TextEditingController();
  String userName = '';
  List<String> savedRecipes = [];
  User? user;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // 사용자가 로그인되어 있지 않은 경우
      Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지로 이동
    } else {
      await Future.wait([_getUserData(), _getSavedRecipes()]);
    }
  }

  Future<void> _getUserData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      userName = userDoc['name'] ?? 'Anonymous';
      _nameController.text = userName;
    });
  }

  Future<void> _getSavedRecipes() async {
    QuerySnapshot recipesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .get();
    setState(() {
      savedRecipes =
          recipesSnapshot.docs.map((doc) => doc['title'] as String).toList();
    });
  }

  Future<void> _saveUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .set({'name': _nameController.text});
    setState(() {
      userName = _nameController.text;
    });
  }

  void _logout() {
    if (user != null) {
      FirebaseAuth.instance.signOut().then((_) {
        Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지로 이동
      });
    } else {
      // 로그인이 되어 있지 않은 경우 알림 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('로그인 상태가 아닙니다. 먼저 로그인하세요.'),
      ));
    }
  }

  Future<void> _deleteAccount() async {
    if (user != null) {
      try {
        String userId = user!.uid;

        // Firestore에서 사용자 문서 삭제
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .delete();
       
        // Firebase Auth에서 사용자 삭제
        await user!.delete();

        // 로그아웃 처리 및 로그인 페이지로 이동
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지로 이동
      } catch (e) {
        // 오류 처리
        print('계정을 삭제하는 동안 오류가 발생했습니다: $e');
      }
    } else {
      // 로그인이 되어 있지 않은 경우 알림 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('로그인 상태가 아닙니다. 먼저 로그인하세요.'),
      ));
    }
  }

  void _navigateToSavedRecipes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedRecipesPage()), // 찜리스트 페이지로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.02),
          ProfileUserName(screenWidth, userName),
          SizedBox(height: screenHeight * 0.02),
          SizedBox(height: screenHeight * 0.02),
          SavedRecipes(screenWidth, savedRecipes, _navigateToSavedRecipes),
          SizedBox(height: screenHeight * 0.02),
          AccountSection(screenWidth, screenHeight, _saveUserName),
          SizedBox(height: 16),
          Divider(color: Color(0xFFE6E6E6)),
          SizedBox(height: 16),
          SupportSection(screenWidth, screenHeight),
          SizedBox(height: 16),
          Divider(color: Color(0xFFE6E6E6)),
          SizedBox(height: 16),
          AccountManagement(screenWidth, screenHeight, _logout, _deleteAccount),
        ],
      ),
    );
  }
}