import 'package:flutter/material.dart';
import 'package:hotbap/btm_nvg_bar.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/pages/profile/profile_page.dart';
import 'package:hotbap/pages/search/search_page.dart';

class ContainerPage extends StatefulWidget{
  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          MainPage(),
          SearchPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
