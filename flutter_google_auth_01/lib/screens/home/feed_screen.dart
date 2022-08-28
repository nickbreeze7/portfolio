import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../sign_in.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  //const ProfileScreen({Key? key}) : super(key: key);
  //final User _user;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Row(
        children: [
          /*    ClipOval(
            child: Image.network(
              'https://avatars.githubusercontent.com/u/14922088?v=4',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),*/
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 30, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name + '님 안녕하세여',
                  style: TextStyle(color: Colors.blue[900], fontSize: 20),
                ),
                Text(
                  '근처에 있는 바버샾을 ',
                  style: TextStyle(color: Colors.blue[900], fontSize: 20),
                ),
                Text(
                  '추천해 드리겠습니다.',
                  style: TextStyle(color: Colors.blue[900], fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
