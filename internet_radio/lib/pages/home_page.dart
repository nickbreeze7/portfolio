import 'package:flutter/material.dart';
import 'package:internet_radio/pages/fav_radios_page.dart';
import 'package:internet_radio/services/db_download_service.dart';
import 'package:internet_radio/utils/hex_color.dart';
import 'package:internet_radio/pages/radio_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    new RadioPage(
      isFavouriteOnly: false,
    ),
    FavRadiosPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: HexColor("#182545"),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: HexColor("#ffffff"),
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          items: [
            _bottomNavItem(Icons.play_arrow, "Listen"),
            _bottomNavItem(Icons.favorite, "Favorite")
          ],
          onTap: onTabTapped,
        ),
      ),
    );
  }

  _bottomNavItem(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: new Icon(
        icon,
        color: HexColor("#6d7381"),
      ),
      activeIcon: new Icon(
        icon,
        color: HexColor("#ffffff"),
      ),
      title: new Text(
        title,
        style: TextStyle(
          color: HexColor("#ffffff"),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    if (!mounted) return;
    setState(() {
      _currentIndex = index;
    });
  }
}
