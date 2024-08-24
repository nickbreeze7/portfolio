import 'package:flutter/material.dart';
import 'package:nearbarbershop2/screens/map/map_screen.dart';
import 'package:nearbarbershop2/screens/mobile_layout/mobile_screen_layout.dart';
import 'package:nearbarbershop2/sign_in.dart';

import 'main.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Set height
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/barbershop.jpg"),
                fit: BoxFit.cover,
              ),
            ),

            child:Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  //mainAxisSize: MainAxisSize.min, // Change to MainAxisSize.min
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // const FlutterLogo(size: 150),
                   // const SizedBox(height: 650),
                    _signInButton(),
                  ],
                ),
              ),
            ),
            ),
        ),
        ),

    );
  }

  Widget _signInButton() {
    return OutlinedButton(
      //splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  //return FirstScreen();
                  return const MobileScreenLayout();
               //     return const MapScreen();
                //  return NaverMapApp();
                },
              ),
            );
          }
        });
      },
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      // highlightElevation: 0,
      //  borderSide: BorderSide(color: Colors.grey),

      child:  const Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

