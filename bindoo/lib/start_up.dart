
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Config/config.dart';
import 'Counters/cart_count.dart';
import 'account_page.dart';
import 'category_page.dart';
import 'home_page.dart';
import 'my_cart.dart';



class StartUpPage extends StatefulWidget {


  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
   HomePage(),
    CategoryPage(),
    MyCart(),
    AccountPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          onTap: onTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: new Text(
                  "Home",
                  
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: new Text(
                  "Categories",

                )),

            BottomNavigationBarItem(
                icon: new Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    Icon(Icons.shopping_cart),
                    new CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 8,
                      child:Consumer<CartItemCounter>(
                        builder: (context, counter,_){
                          return Text((BindooApp.sharedPreferences.getStringList(BindooApp.userCartList).length-1).toString(),
                            style: TextStyle(color: Colors.white,fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                title: new Text(
                  "Cart",

                )),
            BottomNavigationBarItem(

                icon: Icon(Icons.person),
                title: new Text(
                  "Account",

                )),

          ],
        ),
      ),
    );
  }

  onTapped(int index) {
    setState(() {
      _currentIndex = index;

    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Confirm Exit"),
            content: Text("Are you sure you want to exit?"),
            actions: <Widget>[
              FlatButton(
                child: Text("YES"),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              FlatButton(
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    return Future.value(true);
  }


}
