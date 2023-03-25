import 'package:flutter/material.dart';
import 'package:mybarbershop/screens/Map/map_screen.dart';
import 'package:mybarbershop/screens/book/booking_screen.dart';
import 'package:mybarbershop/screens/home/home_screen.dart';
import 'package:mybarbershop/screens/myprofile/profile_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  // 홈화면???
  const HomeScreen(),

  //  구글맵 화면
  MapScreen(),

  // const Text('notifications'),
  /* ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),*/

  const BookingScreen(),

  // 프로필 화면
  const ProfileScreen()
];
