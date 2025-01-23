import 'package:flutter/material.dart';
import 'package:hotbap/pages/profile/widgets/profile_page_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        titleTextStyle: TextStyle(
          color: Color(0xFF333333),
          fontSize: 20,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          height: 1.35,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProfilePageWidget(),
      ),
    );
  }
}
