import 'package:flutter/material.dart';
import 'package:dovewallet_bitcoin/bottomnav.dart';
import 'package:dovewallet_bitcoin/homepage.dart';

void main(){
    runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:BottomNav()
    );
  }
}