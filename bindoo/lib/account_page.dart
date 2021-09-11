

import 'package:bindoo/Config/config.dart';
import 'package:bindoo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'Config/CustomShapeClipper.dart';
import 'edit_profile.dart';








class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[

          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 60 ,
                          width: 60 ,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(BindooApp.sharedPreferences.getString(BindooApp.userAvatarUrl),))
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(BindooApp.sharedPreferences.getString(BindooApp.userName), style: TextStyle(
                                color: Colors.white,
                                fontSize: 16 ,
                                fontWeight: FontWeight.bold
                            ),),
                            Text(BindooApp.sharedPreferences.getString(BindooApp.userEmail), style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14 ,

                            ),),


                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: 20 ),
                    Row(

                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("Balance", style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17 ,
                            ),),
                            Text("GHC 0.00", style: TextStyle(
                                color: Colors.white,
                                fontSize: 17 ,
                                fontWeight: FontWeight.bold
                            ),),

                          ],
                        ),
                        SizedBox(width: 5 ),
                        Container(height: 40, child: VerticalDivider(color: Colors.white)),
                        SizedBox(width: 10 ),
                        Column(
                          children: <Widget>[
                            Text("Orders", style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17 ,
                            ),),
                            Text("0", style: TextStyle(
                                color: Colors.white,
                                fontSize: 17 ,
                                fontWeight: FontWeight.bold
                            ),),

                          ],
                        ),
                        SizedBox(width: 5 ),
                        Container(height: 40, child: VerticalDivider(color: Colors.white)),
                        SizedBox(width: 10 ),
                        OutlineButton(
                            borderSide: BorderSide(color: Colors.white),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            onPressed: (){
                              Navigator.push(
                                  context, PageTransition(type: PageTransitionType.fade, child: EditProfile()));
                            },
                            child: new Text("Edit Profile",style: TextStyle(color: Colors.white),)),

                      ],
                    ),
                    SizedBox(height: 20 ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(top: 200 ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(left: 0.0, top: 3 ),
                      child: Text("About", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    ),
                    SizedBox(height: 3 ),
                    ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text("About Us",),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.mail_outline),
                      title: Text("Contact Us"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.security),
                      title: Text("Privacy Policy"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Logout"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        BindooApp.auth.signOut().then((c){
                          Navigator.push(
                              context, PageTransition(type: PageTransitionType.fade, child: SliderPage()
                          ));

                        });
                        SystemNavigator.pop();
                      },
                    ),




                    SizedBox(height: 3 ,)
                  ],
                ),
              ),
            ),
          )

        ],
      ),

    );
  }
  Widget showProfile(){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 60 ,
              width: 60 ,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/jj.jpg"))
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Bill Mulley", style: TextStyle(
                    color: Colors.white,
                    fontSize: 16 ,
                    fontWeight: FontWeight.bold
                ),),
                Text("asantebenjamin111@gmail.com", style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16 ,

                ),),


              ],
            ),
            SizedBox(width: 25 ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("", style: TextStyle(
                        color: Colors.white,
                        fontSize: 17 ,
                        fontWeight: FontWeight.bold
                    ),),
                    Text("Visits", style: TextStyle(
                      color: Colors.white70,
                      fontSize: 17 ,
                    ),),
                  ],
                ),


              ],
            ),
          ],
        ),
        SizedBox(height: 20 ),

      ],
    );
  }
  void logoutUser() async {
    try {

    } catch (e) {
      print(e.toString());
    }
  }
}

