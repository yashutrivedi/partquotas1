import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:partquotes_admin/screens/admindashboard.dart';
import 'package:partquotes_admin/screens/requestpage.dart';
import 'package:partquotes_admin/screens/setting.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  var myPages = [AdminDashboard(), RequestPage(), Admin_setting()];
  List<IconData> iconList = [
    Icons.dashboard,
    Icons.request_quote,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      body: myPages[currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
         
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Icon(
            iconList[index],
            size: isPortrait ? 24 : 32,
            color: isActive ? Colors.red : Colors.blue,
          );
        },
        activeIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}
