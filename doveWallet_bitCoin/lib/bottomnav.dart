import 'package:flutter/material.dart';
import 'package:dovewallet_bitcoin/aboutpage.dart';
import 'package:dovewallet_bitcoin/homepage.dart';
import 'package:dovewallet_bitcoin/profilepage.dart';
import 'package:dovewallet_bitcoin/settingpage.dart';



class BottomNav extends StatefulWidget {
   BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
  }

  List<Widget> myChilders = const [
    HomePage(),
    ProfilePage(),
    AboutPage(),
    SettingPage(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: myChilders),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight,
        child: BottomAppBar(
          child: TabBar(
            onTap: (index){
              setState(() {
                selectedIndex = index;
              });
            },
            indicator: const UnderlineTabIndicator(
              insets: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              borderSide: BorderSide(color: Colors.red, width: 2)),
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            controller: tabController,
            tabs: [
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: selectedIndex == 0
                  ? const Icon(Icons.home)
                    : const Icon(Icons.home_mini),
                child: const Text(
                  'Home',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.person),
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.info),
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.settings),
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ]),
        ),
      ));
  }
}
