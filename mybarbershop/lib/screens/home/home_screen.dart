
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
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
    final currentPosition =
    Provider.of<Position?>(context); // Position에 ?를 하니까, 로딩할 때 에러가 발생안함!!

    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    //final placesProvider = Provider.of<Future<List<Place>>?>(context, listen: false);
    final placesProvider = Provider.of<Future<List<Place>>?>(context);

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
                  MainSliderScreen1(),
                 ],
      ),
            ),
      )
    );
  }
}

class MainSliderScreen1 extends StatelessWidget {
  const MainSliderScreen1 ({Key? key}) : super(key: key);
  // MapListviewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentPosition =
    Provider.of<Position?>(context); // Position에 ?를 하니까, 로딩할 때 에러가 발생안함!!

    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    //final placesProvider = Provider.of<Future<List<Place>>?>(context, listen: false);
    final placesProvider = Provider.of<Future<List<Place>>?>(context);

    return FutureProvider(
      create: (context) => placesProvider,
      initialData: null,
      child: Container(
        constraints:BoxConstraints(
          minHeight:320,
          maxHeight: 320,
        ),
        child: Scaffold(
          body: (currentPosition != null)
              ? Consumer<List<Place>?>(
                  builder: (_, places, __) {
              // if ((places != null)) {
              return Column(
               // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: places!.length,
                        itemBuilder: (context, index) {
                          return FutureProvider(
                            create: (context) => geoService.getDistance(
                                currentPosition.latitude,
                                currentPosition.longitude,
                                places[index].geometry.location.lat,
                                places[index].geometry.location.lng),
                            initialData: null,
                            child: Container(
                              child: Align(
                                child: Container(
                                  //width: double.infinity,// <== 이걸 사용하면 가로로 보여짐.!!!
                                  //margin: EdgeInsets.only(bottom: 350),
                                  width: 250.0,
                                  height: 250.0,
                                  //20230928
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        places[index].name,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          (places[index].rating != null)
                                              ? Row(
                                            children: <Widget>[
                                              RatingBarIndicator(
                                                rating:
                                                places[index].rating,
                                                itemBuilder: (context,
                                                    index) =>
                                                    Icon(Icons.star,
                                                        color:
                                                        Colors.amber),
                                                itemCount: 5,
                                                itemSize: 10.0,
                                                direction: Axis.horizontal,
                                              )
                                            ],
                                          )
                                              : Row(),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Consumer<double?>(builder:
                                              (context, kilometers, widget) {
                                            return (kilometers != null)
                                                ? Text(
                                              // 일단  miles로 나타내고 , 추후에 킬로미터로 바꿈.
                                              // '${places[index].vicinity}\u00b7 ${(meters / 1609).round()} mi')
                                                '${places[index].vicinity}\u00b7 ${(kilometers / 1000).round()} km')
                                                : Container();
                                          })
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.directions),
                                        color: Theme.of(context).primaryColor,
                                        // onPressed 누르면  예약하기로 넘어가기
                                        // markerService에  InfoWindow에 화면 크게 해서
                                        // 웬만한 정보 다 담기
                                        onPressed: () {
                                          /* _launchMapsUrl(
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lat,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lng);*/
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
              /* } else {
                        return Center(child: CircularProgressIndicator());
                      }*/
            },
          )
              : Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}