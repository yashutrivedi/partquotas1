import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'cartpage.dart';
import 'dashboard.dart';
import 'quotationstatus.dart';
import 'setting.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  var myPages = [
    ClientDashboard(),
    QuotationStatus(),
    CartPage(),
    Client_setting()
  ];
  List<IconData> iconList = [
    Icons.dashboard,
    Icons.request_quote,
    Icons.shopping_cart,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      body: myPages[currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        gapWidth: 10,
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
