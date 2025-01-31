import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotbap/pages/profile/widgets/profile_user_name.dart';
import 'package:hotbap/pages/profile/widgets/saved_recipes.dart';
import 'package:hotbap/pages/profile/widgets/account_section.dart';
import 'package:hotbap/pages/profile/widgets/account_management.dart';
import 'package:hotbap/pages/profile/widgets/support_section.dart';
import 'package:hotbap/pages/savedrecipes/saved_recipes_page.dart';

class ProfilePageWidget extends StatefulWidget {
  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  final TextEditingController _nameController = TextEditingController();
  String userName = '';
  List<String> savedRecipes = [];
  User? user;
  bool isLoading = true; // 로딩 상태를 나타내는 변수

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지로 이동
    } else {
      await Future.wait([_getUserData(), _getSavedRecipes()]);
    }
    setState(() {
      isLoading = false; // 로딩이 완료되었음을 표시
    });
  }

  Future<void> _getUserData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    setState(() {
      userName = userDoc['userName'] ?? 'Anonymous';
      _nameController.text = userName;
    });
  }

  Future<void> _getSavedRecipes() async {
    QuerySnapshot recipesSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('favorites')
        .get();
    setState(() {
      savedRecipes =
          recipesSnapshot.docs.map((doc) => doc['title'] as String).toList();
    });
  }

  Future<void> _saveUserName() async {
    if (user != null) {
      try {
        await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .update({'userName': _nameController.text});
        setState(() {
          userName = _nameController.text;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('닉네임이 성공적으로 저장되었습니다.'),
        ));
        // 닉네임 저장 후 데이터를 다시 불러옴
        await _getUserData();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('닉네임 저장 중 오류가 발생했습니다: $error'),
        ));
      }
    }
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // 로그아웃 처리
      Navigator.pushReplacementNamed(context, '/login'); // 로그아웃 후 로그인 페이지로 이동
    } catch (error) {
      // 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('로그아웃 중 오류가 발생했습니다: $error'),
      ));
    }
  }

  Future<void> _deleteAccount() async {
    if (user != null) {
      try {
        String userId = user!.uid;

        // Firestore에서 사용자 문서 삭제
        await FirebaseFirestore.instance
            .collection('user')
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
      MaterialPageRoute(builder: (context) => SavedRecipesPage(userId: user!.uid)), // userId를 전달
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('user').doc(user!.uid).snapshots(),  // 'users' 대신 'user'로 수정
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Text('데이터를 불러올 수 없습니다.');
                    }
                    var userData = snapshot.data!.data() as Map<String, dynamic>;
                    userName = userData['userName'] ?? 'Anonymous';
                    _nameController.text = userName;
                    return ProfileUserName(screenWidth, userName);
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('user').doc(user!.uid).collection('favorites').snapshots(),  // 'users' 대신 'user'로 수정
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData) {
                      return Text('저장된 레시피가 없습니다.');
                    }
                    savedRecipes = snapshot.data!.docs.map((doc) => doc['title'] as String).toList();
                    return SavedRecipes(screenWidth, savedRecipes, _navigateToSavedRecipes);
                  },
                ),
                SizedBox(height: 16),
                AccountSection(screenWidth, screenHeight, _saveUserName),
                SizedBox(height: 16), // 간격 추가
                Divider(color: Color(0xFFE6E6E6)),
                SizedBox(height: 16), // 간격 추가
                SupportSection(screenWidth, screenHeight),
                SizedBox(height: 16), // 간격 추가
                Divider(color: Color(0xFFE6E6E6)),
                SizedBox(height: 16), // 간격 추가
                AccountManagement(screenWidth, screenHeight, _logout, _deleteAccount),
              ],
            ),
          );
  }
}