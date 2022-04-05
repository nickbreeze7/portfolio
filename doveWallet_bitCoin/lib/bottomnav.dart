import 'package:dovewallet_bitcoin/mypage.dart';
import 'package:dovewallet_bitcoin/savingspage.dart';
import 'package:dovewallet_bitcoin/tradepage.dart';
import 'package:dovewallet_bitcoin/walletpage.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

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
    tabController = TabController(length: 5, vsync: this);
  }

  List<Widget> myChildern = <Widget>[
    HomePage(),
    WalletPage(),
    TradePage(),
    SavingsPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: myChildern),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomAppBar(
            child: TabBar(
                onTap: (index) {
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
                    iconMargin: EdgeInsets.only(bottom: 2),
                    icon: selectedIndex == 0
                        ? const Icon(Icons.home)
                        : const Icon(Icons.home_mini),
                    child: const Text(
                      'Home',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  const Tab(
                    iconMargin: EdgeInsets.only(bottom: 2),
                    icon: Icon(Icons.wallet_membership),
                    child: Text(
                      'Wallet',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  const Tab(
                    iconMargin: EdgeInsets.only(bottom: 2),
                    icon: Icon(Icons.arrow_forward),
                    child: Text(
                      'Trade',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  const Tab(
                    iconMargin: EdgeInsets.only(bottom: 2),
                    icon: Icon(Icons.savings),
                    child: Text(
                      'Savings',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  const Tab(
                    iconMargin: EdgeInsets.only(bottom: 2),
                    icon: Icon(Icons.person),
                    child: Text(
                      'Mypage',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
