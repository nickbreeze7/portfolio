import 'dart:async';
import 'dart:math';
import 'package:bindoo/Config/config.dart';
import 'package:bindoo/Counters/cart_count.dart';
import 'package:bindoo/Counters/item_quantity.dart';
import 'package:bindoo/Counters/total_amount.dart';
import 'package:bindoo/home_page.dart';
import 'package:bindoo/start_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/login_register.dart';
import 'Config/config.dart';
import 'Config/config.dart';
import 'Models/slide.dart';
import 'Widget/slide_dots.dart';
import 'Widget/slider_item.dart';












Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BindooApp.auth = FirebaseAuth.instance;
  BindooApp.sharedPreferences=await SharedPreferences.getInstance();
  BindooApp.firestore = Firestore.instance;
  var email = BindooApp.sharedPreferences.getString('email');
  print(email);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (c)=>CartItemCounter()),
          ChangeNotifierProvider(
              create: (c)=>ItemQuantity()),
          ChangeNotifierProvider(
              create: (c)=>TotalAmount()),
          ChangeNotifierProvider(
              create: (c)=>CartItemCounter()),
        ],
       child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Nunito',
            primaryColor: const Color(0xFF00C9C9),

            accentColor: const Color(0xFF030C54),
          ),
          home: SliderPage(),
        ),);
  }
}
class SliderPage extends StatefulWidget {

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if(_currentPage<2){
        _currentPage++;
      }
      else{
        _currentPage=0;
      }
      _pageController.animateToPage(_currentPage, duration: Duration(milliseconds:300 ), curve: Curves.easeIn);
    });
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index){
    setState(() {
      _currentPage=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                    onPageChanged: _onPageChanged,
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    itemCount: slideList.length,
                    itemBuilder: (context,index)=>SlideItem(index)),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 35),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for(int index = 0;index<slideList.length; index++)
                            if(index==_currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("GET STARTED"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  textColor: Colors.white,
                  onPressed: (){
                   checkUser(); }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Have An Account?",style: TextStyle(color: Colors.grey),),
                  FlatButton(
                      onPressed: (){
                        Navigator.push(
                            context, PageTransition(type: PageTransitionType.fade, child: LoginRegister()));

                      },
                      child: Text("Login"))
                ],
              )
            ],
          ),
        ],


      ),

    );
  }
  Future<void> checkUser() async {
    if(await BindooApp.auth.currentUser() != null){
      Route route = MaterialPageRoute(builder: (_)=>StartUpPage());
      Navigator.pushReplacement(context, route);
    }
    else{
      Route route = MaterialPageRoute(builder: (_)=>LoginRegister());
      Navigator.pushReplacement(context, route);
    }

  }
}