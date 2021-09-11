

import 'package:flutter/material.dart';

import 'categories/babies_category.dart';
import 'categories/bag_category.dart';
import 'categories/beauty_health.dart';
import 'categories/computer_accessories.dart';
import 'categories/electronics_category.dart';
import 'categories/home_decor_page.dart';
import 'categories/jewelry_page.dart';
import 'categories/kitchen_set.dart';
import 'categories/men_category.dart';
import 'categories/mobile_accessories.dart';
import 'categories/shoes_category.dart';
import 'categories/women_category.dart';





class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  String title = "Screen 0";
  TabController _tabController;
  PageController _pageController;


  @override
  void initState() {
    _pageController = PageController();
    _tabController = TabController(initialIndex: 0, length: 12, vsync: this);
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          {
            setState(() {
              title = "Women";
              _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);

            });
            break;
          }
        case 1:
          {
            setState(() {
              title = "Men";
              _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
        case 2:
        {
          setState(() {
            title = "DashBoard";
            _pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
          break;
        }
        case 3:
          {
            setState(() {
              title = "DashBoard";
              _pageController.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
        case 4:
          {
            setState(() {
              title = "Bags";
              _pageController.animateToPage(4, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
        case 5:
          {
            setState(() {
              title = "Bags";
              _pageController.animateToPage(5, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
        case 6:
        {
          setState(() {
            title = "Bags";
            _pageController.animateToPage(6, duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
          break;
        }
        case 7:
          {
            setState(() {
              title = "Bags";
              _pageController.animateToPage(7, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
        case 8:
          {
            setState(() {
              title = "Bags";
              _pageController.animateToPage(8, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
        case 9:
          {
            setState(() {
              title = "Bags";
              _pageController.animateToPage(9, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
        case 10:
          {
            setState(() {
              title = "Bags";
              _pageController.animateToPage(10, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
        case 11:
          {
            setState(() {
              title = "Bags";
              _pageController.animateToPage(11, duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
            break;
          }
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      body: Row(
        children: <Widget>[
          RotatedBox(
            quarterTurns: 1,
            child: TabBar(

              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 6)
              ),
              isScrollable: true,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).accentColor,
              controller: _tabController,
              tabs: <Widget>[
                getItem(
                  image: new Image.asset(
                    'images/ladies.png',
                    height: 35,
                  ),
                  text: Text(
                    "Women",

                  ),
                  subText:  Text(
                    "Clothing",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/men.png',
                    height: 35,
                  ),
                  text: Text(
                    "Men",

                  ),
                  subText:  Text(
                    "Clothing",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/phones.png',
                    height: 35,
                  ),
                  text: Text(
                    "Phones",

                  ),
                  subText:  Text(
                    "Accessories",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/electronics.png',
                    height: 35,
                  ),
                  text: Text(
                    "Consumer",

                  ),
                  subText:  Text(
                    "Electronics",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/jewelry.png',
                    height: 35,
                  ),
                  text: Text(
                    "Jewelry",

                  ),
                  subText:  Text(
                    "& Watches",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/home.png',
                    height: 35,
                  ),
                  text: Text(
                    "Home",

                  ),
                  subText:  Text(
                    "Decor",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/computers.png',
                    height: 35,
                  ),
                  text: Text(
                    "Computer",

                  ),
                  subText:  Text(
                    "Accessories",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/shoes.png',
                    height: 35,
                  ),
                  text: Text(
                    "Shoes",

                  ),
                  subText:  Text(
                    "Men/Women",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/bags.png',
                    height: 35,
                  ),
                  text: Text(
                    "Bags",

                  ),
                  subText:  Text(
                    "Men/Women",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/kitchen.png',
                    height: 35,
                  ),
                  text: Text(
                    "Kitchen",

                  ),
                  subText:  Text(
                    "Gadgets",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/bby.png',
                    height: 35,
                  ),
                  text: Text(
                    "Babies",

                  ),
                  subText:  Text(
                    "& Toys",

                  ),
                ),
                getItem(
                  image: new Image.asset(
                    'images/beauty.png',
                    height: 35,
                  ),
                  text: Text(
                    "Beauty",

                  ),
                  subText:  Text(
                    "& Health",

                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                WomenCategory(),
                MenCategory(),
                MobileAccessories(),
                ElectronicsPage(),
                JewelryPage(),
                HomeDecorPage(),
                ComputerAccessories(),
                ShoeCategory(),
                BagCategory(),
                KitchenSets(),
                BabyCategory(),
                BeautyHealth()
              ],
            ),

          )
        ],
      ),

    );
  }

  Widget getItem({Image image, Text text, Text subText}) {
    return RotatedBox(
      quarterTurns: -1,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[image, text,subText],
        ),

    );
  }



}



