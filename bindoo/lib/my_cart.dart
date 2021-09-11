
import 'package:bindoo/search_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'cart_list.dart';
import 'my_orders.dart';


class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    TabController _tabController;


    _tabController = new TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        title: Text('Cart & Orders',style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, PageTransition(type: PageTransitionType.fade, child: SearchPage()));
              }),



        ],
        bottom: TabBar(
            unselectedLabelColor: Colors.black54,
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.white,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white,width: 3)
            ),
            tabs: [
              Tab(
                child: Text("My Cart",style: TextStyle(fontSize: 20),),

              ),
              Tab(
                child: Text("My Orders",style: TextStyle(fontSize: 20),),

              ),

            ]),
      ),
      body: TabBarView(children: [
        CartList(),
        MyOrders()
        ],
        controller: _tabController,),
    );
  }
}
