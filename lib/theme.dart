import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotbap/pages/main/main_page.dart';
import 'package:hotbap/pages/search/search_page.dart';
import 'package:hotbap/pages/profile/profile_page.dart';

final ThemeData appTheme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFFD6512C),
    unselectedItemColor: Color(0xFF989898),
  ),
);

List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    icon: SizedBox(
      child: SvgPicture.asset(
        'assets/icons/svg/Home_Default.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Color(0xFF989898), BlendMode.srcIn),
      ),
    ),
    activeIcon: SizedBox(
      child: SvgPicture.asset(
        'assets/icons/svg/Home_filled.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Color(0xFFD6512C), BlendMode.srcIn),
      ),
    ),
    label: '홈',
  ),
  BottomNavigationBarItem(
    icon: SizedBox(
      child: SvgPicture.asset(
        'assets/icons/svg/Magnifier_Default.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Color(0xFF989898), BlendMode.srcIn),
      ),
    ),
    activeIcon: SizedBox(
      child: SvgPicture.asset(
        'assets/icons/svg/Magnifier_filled.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Color(0xFFD6512C), BlendMode.srcIn),
      ),
    ),
    label: '검색',
  ),
  BottomNavigationBarItem(
    icon: SizedBox(
      child: SvgPicture.asset(
        'assets/icons/svg/Person_Default.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Color(0xFF989898), BlendMode.srcIn),
      ),
    ),
    activeIcon: SizedBox(
      child: SvgPicture.asset(
        'assets/icons/svg/Person_filled.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Color(0xFFD6512C), BlendMode.srcIn),
      ),
    ),
    label: '마이',
  ),
];

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  BottomNavBar({this.initialIndex = 0});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: bottomNavItems,
    );
  }
}
