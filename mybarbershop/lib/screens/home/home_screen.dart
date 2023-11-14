
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/place.dart';
import '../../services/geolocator_service.dart';
import '../../services/marker_service.dart';
import '../Map/map_listview_screen.dart';
import '../map/main_slider_screen.dart';
import 'home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //const ProfileScreen({Key? key}) : super(key: key);
  //final User _user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  //late User _user;
  late String username;
  String userEmail = "";


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    userEmail = googleUser.email;
    print(userEmail);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
      body: SafeArea(
            child: Container(
              constraints:BoxConstraints(
                minHeight:400,
                maxHeight: 400,
              ),
              child: ListView(
                children:   [
                  HomeHeader(),
                  SizedBox(height: 20),
                  //MainSliderScreen1(),
                  ProviderScope(
                      child:LocationTest(),
                  ),
                 ],
      ),
            ),
      )
    );
  }
}

