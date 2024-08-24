
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/place.dart';
import 'home_box.dart';
import 'home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, right: 30),
      //padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: SafeArea(
              child: Container(
                constraints:const BoxConstraints(
                  minHeight:200,     //400
                  maxHeight: 800,    //400
                ),
                child: ListView(
                  children:   const [
                      HomeHeader(),
                    SizedBox(height: 50),// 이걸로 이름하고 밑에 슬라이드 박스 간격 조절// 20231126
                     HomeBox(),
                    SizedBox(height: 30),
                    LocationTest(),
                   ],
        ),
              ),
        )
      ),
    );
  }
}

