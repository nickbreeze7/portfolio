import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mybarbershop/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../models/place.dart';
import '../../services/geolocator_service.dart';
import '../../services/getTodayHours.dart';
import '../../services/marker_service.dart';
import '../../services/places_service.dart';
import 'map_listview_screen.dart';

//********* Global Variables */
/*const LatLng _center = const LatLng(36.737232, 3.086472);
late LatLng newPosition;
CameraPosition newCameraPosition =
    CameraPosition(target: LatLng(36.6993, 3.1755), zoom: 20);*/

// 일단 현재 위치 하드코딩하고 나중에 자연적으로 받아오게끔 해야 됨... 바꿔야 됨.
// 20230129
/*
var logger = Logger(
  printer: PrettyPrinter(),
);
*/

//final currentPosition = Provider.of<Position?>(context);

var location = new Location();
LocationData? currentLocation;
late Position? currentPosition;

/*Future<void> _getLocation() async {
  try {
    currentLocation = await location.getLocation();
  } catch (e) {
    print('ERROR: $e');
    currentLocation = null;
  }
}*/

CameraPosition newCameraPosition =
      CameraPosition(target: LatLng(36.8141, 127.1465), zoom: 20);
     // CameraPosition(target: LatLng( currentPosition!.latitude, currentPosition!.longitude), zoom: 20);


late LatLng newPosition;


Set<Marker> markers = {};
// final Set<Marker> _secondMarkers= {};
//var markers = <Marker>[];

int _index = 0;
//int? indexMarker;
var indexMarker;

ValueNotifier valueNotifier = ValueNotifier(indexMarker);

//*********StatefulWidget */
class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  //State<MapSearchScreen> createState() => _MapSearchScreenState();
  //_MainScreenState createState() => _MainScreenState();
  _MapSearchScreenState createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  //******** Map variables */
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  late BitmapDescriptor customIcon;

  //  추가 20230815
  Future<List<Place>>? place;
  //Future<List<Business>>? businesses;
  //final Place places;

  void getMarkers() async {
    markers = {};
    // List<Place>? places;
    List<Place>? places;
    places?.forEach((place) {
      if (place.geometry.location.lat != null &&
          place.geometry.location.lng != null) {
        if (place.placeId == indexMarker) {
          markers.add(Marker(
              draggable: false,
              markerId: MarkerId(place.name),
              position: LatLng(
                  place.geometry.location.lat, place.geometry.location.lng),
              infoWindow: InfoWindow(title: place.name)));
        } else {
          markers.add(Marker(
              draggable: false,
              markerId: MarkerId(place.name),
              position: LatLng(
                  place.geometry.location.lat, place.geometry.location.lng),
              infoWindow: InfoWindow(title: place.name)));
        }
      }
    });
    valueNotifier.value = indexMarker;
  }

  //****** OnMapCreated */
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
  }

  final kGoogleApiKey = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  String buildPhotoURL(String photoReference) {
    //return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
  }


  @override
  void initState() {
    // getMarkers();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition =
    Provider.of<Position?>(context); // Position에 ?를 하니까, 로딩할 때 에러가 발생안함!!
    final placesProvider = Provider.of<Future<List<Place>>?>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    int currentIndex = 0;
    // var myLocationButtonEnabled = false;

    return FutureProvider(
      create: (context) => placesProvider,
      initialData: null,
      /* catchError: (context, error) {
        print(error);
        return 0;
      } ,*/
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>?>(
          builder: (_, places, __) {
            var markers;
            if ((places != null)) {
              markers = markerService.getMarkers(places);
              // logger.d("markers: ------->>>>>" + markers);
            } else {
              markers = <Marker>[];
              ////markers = List<Marker>.empty(growable: false);
            }
            return (places != null)
                ? Column(
              children: <Widget>[
                Expanded(
                    child: ValueListenableBuilder(
                      // height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                        valueListenable: valueNotifier,
                        builder: (context, value, child) {
                          return GoogleMap(
                            zoomGesturesEnabled: true,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            zoomControlsEnabled: true,
                            // 20221126-.toSet() 이것때문에 됨!!
                            markers: markers.toSet(),
                            //markers: Set<Marker>.of(markers),
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  currentPosition.latitude,
                                  currentPosition.longitude),
                              zoom: 14.0,
                            ),
                          );
                        })),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SizedBox(
                        height: 116, // card height
                        child: PageView.builder(
                          itemCount: places.length,
                          controller:  PageController(viewportFraction: 0.9),
                          onPageChanged: (int index) {
                            //markers
                            setState(() => _index = index
                            );
                            //indexMarker = places[index].placeId;
                            //logger.d("indexMarker:=====>>> " + indexMarker);
                            if (places[index]
                                .geometry
                                .location
                                .lat !=
                                null &&
                                places[index]
                                    .geometry
                                    .location
                                    .lng !=
                                    null
                            ) {
                              newPosition = LatLng(
                                  places[index]
                                      .geometry
                                      .location
                                      .lat,
                                  places[index]
                                      .geometry
                                      .location
                                      .lng);
                              newCameraPosition = CameraPosition(
                                  target: newPosition, zoom: 17);
                              //target: newPosition, zoom: 14);
                            }
                            //  getMarkers();
                            mapController
                                ?.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    newCameraPosition))
                                .then((val) {
                              setState(() {
                                // valueNotifier.value = indexMarker;
                                //_index = 0;
                                // _index = currentIndex;
                              });
                            });
                          },
                          itemBuilder: (_, i) {
                            return Transform.scale(
                              scale: i == _index ? 1 : 0.9,
                              child: new Container(
                                height: 116.00,
                                width: 325.00,
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.5, 0.5),
                                      color: Color(0xff000000)
                                          .withOpacity(0.12),
                                      blurRadius: 20,
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.circular(10.00),
                                ),
                                // fix renderflex overflowed by 18 pixels on the bottom error
                                child: Row(
                                  children: <Widget>[
                                    Expanded(  // 이거 써서 Row 에러 해결.. 그담에 사진...
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 30,
                                            top: 7,
                                            bottom: 7,
                                            right: 9),
                                        child: ClipRRect(
                                          child: Container(
                                            height: 86.00,
                                            width: 86.00,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image:
                                                  (places[i].photos != null)?
                                                    NetworkImage(
                                                      buildPhotoURL(places[i].photos![0].photoReference)
                                                  )
                                                      : AssetImage(
                                                      'assets/barbershop.jpg') as ImageProvider
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  5.00),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 12, right: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        children: <Widget>[
                                          Wrap(
                                            alignment:
                                            WrapAlignment.start,
                                            spacing: 2,
                                            direction:
                                            Axis.vertical,
                                            children: <Widget>[
                                              Text(
                                                places[i].name,
                                                style: TextStyle(
                                                  fontFamily:
                                                  "Montserrat",
                                                  fontSize: 15,
                                                  color: Color(
                                                      0xff000000),
                                                ),
                                              ),
                                              (places[i].rating != null)
                                                  ? Row(
                                                children: <Widget>[
                                                  RatingBarIndicator(
                                                    rating:
                                                    places[i].rating,
                                                    itemBuilder: (context, index) =>
                                                        Icon(Icons.star,
                                                            color:
                                                            Colors.amber),
                                                    itemCount: 5,
                                                    // itemCount: places!.length,
                                                    itemSize: 10.0,
                                                    direction: Axis.horizontal,
                                                  )
                                                ],
                                              ) :
                                              Row(),
                                           /*  Container(
                                                width: 200,
                                                child: Text(
                                                  places[i].openingHours!.openNow != false ? '영업 중' : '영업종료',
                                                    //'${places[i].openingHours!.openNow ? 'Open' : 'Closed' } | ${getTodayHours(places[i].openingHours!.weekdayText)}',
                                                      overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                      fontFamily:
                                                      "Montserrat",
                                                      fontSize: 10,
                                                      color: Color(
                                                          0xff000000)
                                                  ),
                                                ),
                                              ),*/
                                              Row(),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  places[i]
                                                      .vicinity,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    "Montserrat",
                                                    fontSize: 10,
                                                    color: Color(
                                                        0xff000000),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: Text('목록보기'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                           // builder: (_) => MapListviewScreen()));
                    builder: (_) => MapListviewScreen(  places: places,)));

                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            )
                : Center(child: CircularProgressIndicator());
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
