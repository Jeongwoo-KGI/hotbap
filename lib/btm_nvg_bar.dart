import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
//navigator -> Indexed Stack Btm Nvg Bar
