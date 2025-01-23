import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotbap/pages/profile/widgets/profile_header.dart';
import 'package:hotbap/pages/profile/widgets/profile_user_name.dart';
import 'package:hotbap/pages/profile/widgets/saved_recipes.dart';
import 'package:hotbap/pages/profile/widgets/account_section.dart';
import 'package:hotbap/pages/profile/widgets/support_section.dart';

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
    if (user != null) {
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
        .collection('recipes')
        .where('userId', isEqualTo: user!.uid)
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
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지로 이동
    });
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
          ProfileHeader(screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.02),
          ProfileUserName(screenWidth, userName),
          SizedBox(height: screenHeight * 0.02),
          ElevatedButton(
            onPressed: () {},
            child: Text('저장한 레시피'),
          ),
          SizedBox(height: screenHeight * 0.02),
          SavedRecipes(screenWidth, savedRecipes),
          SizedBox(height: screenHeight * 0.02),
          AccountSection(screenWidth, screenHeight, _saveUserName),
          SupportSection(screenWidth, screenHeight, _logout),
        ],
      ),
    );
  }
}
