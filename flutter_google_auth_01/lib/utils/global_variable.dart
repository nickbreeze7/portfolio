import 'package:flutter/material.dart';
import 'package:flutter_google_auth_01/screens/Map/map_screen.dart';
import 'package:flutter_google_auth_01/screens/book/booking_screen.dart';
import 'package:flutter_google_auth_01/screens/home/feed_screen.dart';
import 'package:flutter_google_auth_01/screens/myprofile/profile_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  // 홈화면???
  const FeedScreen(),

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
