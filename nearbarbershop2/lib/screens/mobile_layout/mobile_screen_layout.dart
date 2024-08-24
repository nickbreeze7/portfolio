import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../utils/colors.dart';
import '../book/booking_screen.dart';
import '../home/home_screen.dart';
import '../map/map_screen.dart';
import '../myprofile/profile_screen.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  /*void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }*/

/*
  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }
*/

  void onTabTapped(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        //onPageChanged: onPageChanged,
        index: _page,
        children:  const [
           HomeScreen(),
          MapScreen(),
           BookingScreen(),
           ProfileScreen(),
        ]

        /* child: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: homeScreenItems,
          controller: pageController,
          onPageChanged: onPageChanged,
        ),*/

      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        onTap: onTabTapped,
        currentIndex: _page,
        //selectedIndex: _page,
       /* onTabTapped : (int index) {
          setState(() {
            _page = index;
          });
        },*/
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                // 원래  add circle
                Icons.map,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                // 원래  Favorite
                Icons.bookmark,
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          /*BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: (_page == 3) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 3) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],

      ),
    );
  }
}
