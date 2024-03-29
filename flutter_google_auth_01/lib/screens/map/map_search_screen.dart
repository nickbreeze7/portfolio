import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/place.dart';
import '../../services/geolocator_service.dart';
import '../../services/marker_service.dart';
import 'map_listview_screen.dart';

//********* Global Variables */
/*const LatLng _center = const LatLng(36.737232, 3.086472);
late LatLng newPosition;
CameraPosition newCameraPosition =
    CameraPosition(target: LatLng(36.6993, 3.1755), zoom: 20);*/

CameraPosition newCameraPosition =
    CameraPosition(target: LatLng(36.8141, 127.1465), zoom: 20);

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

  //******* getMarkers */
/*  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);

    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }*/

  void getMarkers() async {
/*    final Uint8List userMarkerIcon =
        await getBytesFromAsset('assets/normalMarker.png', 75);

    final Uint8List selectedMarkerIcon =
        await getBytesFromAsset('assets/selectedMarker.png', 100);*/
    markers = {};

    //Set<Marker> markers = {};
    //var markers = <Marker>[];
    List<Place>? places;

    /*BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/google_logo.png',
    );*/

    places?.forEach((place) {
      if (place.geometry.location.lat != null &&
          place.geometry.location.lng != null) {
        if (place.placeId == indexMarker) {
          markers.add(Marker(
              draggable: false,
              markerId: MarkerId(place.name),
              position: LatLng(
                  place.geometry.location.lat, place.geometry.location.lng),
              //icon: BitmapDescriptor.fromAssetImage(configuration, 'assets/google_logo.png'),
              // icon: BitmapDescriptor.fromBytes(selectedMarkerIcon),
              infoWindow: InfoWindow(title: place.name)));
        } else {
          markers.add(Marker(
              draggable: false,
              markerId: MarkerId(place.name),
              position: LatLng(
                  place.geometry.location.lat, place.geometry.location.lng),
              //icon: BitmapDescriptor.fromBytes(userMarkerIcon),
              // icon: place.icon,
              //icon: BitmapDescriptor.defaultMarker,
              //icon: place.icon,
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

  @override
  void initState() {
    getMarkers();
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
    final placesProvider =
        Provider.of<Future<List<Place>>?>(context, listen: false);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      initialData: null,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>?>(
                builder: (_, places, __) {
                  var markers;
                  if ((places != null)) {
                    markers = markerService.getMarkers(places);
                  } else {
                    markers = <Marker>[];
                    //markers = List<Marker>.empty(growable: false);
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
                                          ));
                                    })),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 78.0),
                                  child: SizedBox(
                                    height: 116, // card height
                                    child: PageView.builder(
                                      itemCount: places.length,
                                      controller:
                                          PageController(viewportFraction: 0.9),
                                      onPageChanged: (int index) {
                                        setState(() => _index = index);
                                        indexMarker = places[index].placeId;

                                        if (places[index]
                                                    .geometry
                                                    .location
                                                    .lat !=
                                                null &&
                                            places[index]
                                                    .geometry
                                                    .location
                                                    .lng !=
                                                null) {
                                          newPosition = LatLng(
                                              places[index]
                                                  .geometry
                                                  .location
                                                  .lat,
                                              places[index]
                                                  .geometry
                                                  .location
                                                  .lng);

                                          /*         newPosition = LatLng(
                                          double.parse(places[index]
                                              .geometry
                                              .location
                                              .lat),
                                          double.parse(places[index]
                                              .geometry
                                              .location
                                              .lng));*/

                                          newCameraPosition = CameraPosition(
                                              target: newPosition, zoom: 17);
                                        }
                                        // getMarkers();
                                        mapController
                                            ?.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                    newCameraPosition))
                                            .then((val) {
                                          setState(() {});
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
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 7,
                                                          bottom: 7,
                                                          right: 9),
                                                  child: Container(
                                                    height: 120.00,
                                                    width: 120.00,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            places[i]
                                                                .photos![i]
                                                                .photoReference),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.00),
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
                                                          Container(
                                                            width: 230,
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
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              child: Text('목록보기'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MapListviewScreen()));
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
