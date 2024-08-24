
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_file.dart';
import '../../models/place.dart';

import '../../services/getTodayHours.dart';
import '../../utils/places_notifier2.dart';
import '../../utils/providers_home.dart';
import '../../utils/providers_map.dart' as map_providers;
import '../../utils/providers_map.dart';
import 'map_listview_screen.dart';


var newPosition;
var newCameraPosition;
var mapController;
int  _index = 0;

class MapSearchScreen extends ConsumerWidget {
  const MapSearchScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPositionAsyncValue = ref.watch(map_providers.currentPositionProvider);
    print('currentPositionAsyncValue_Map_Search_Screen :>>>>>>>>>>>>>>>>>>>>>>> $currentPositionAsyncValue');

    final radius = ref.watch(kilometerProvider);
    print("radius_Map_Search_Screen :>>>>>>>>>>>>>>>>>>>>>>> $radius ");

    //final places = ref.watch(map_providers.placesProvider2 (radius) );
    final placesAsyncValue = ref.watch(map_providers.placesProvider7);
    print("placesAsyncValue_Map_Search_Screen :>>>>>>>>>>>>>>>>>>>>>>> $placesAsyncValue ");

    const kGoogleApiKey = 'AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA';
    String buildPhotoURL(String photoReference) {
      //return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
      return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$kGoogleApiKey";
    }

    // Handle different states of currentPositionAsyncValue
    return currentPositionAsyncValue.when(
      data: (position) => _buildScreenContent(ref, position , placesAsyncValue),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error fetching location:>>>>> $e'),
    );
  }

  Widget _buildScreenContent(WidgetRef ref, Position? position, AsyncValue<List<Place>> placesAsyncValue) {
    // Handle different states of placesAsyncValue
    if (position == null) {
      // If position is null, return a widget that indicates no location data is available
      return Center(
        child: Text("Location data not available",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }
    return placesAsyncValue.when(
      data: (places) {
        final markers = _createMarkers(places);
        print('_buildScreenContent_markers:>>>>>>>>>>>>>>>>>> + $markers');
        print('_buildScreenContent_places:>>>>>>>>>>>>>>>>>  $places');

        return Column(
          children: [
            _buildGoogleMap(position, markers),
            _buildPlacesList(places),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error fetching places:>>>>>>>>>>>>>> $e'),
    );
  }

  List<Marker> _createMarkers(List<Place> places) {
    final List<Marker> markers = [];

    for (var place in places) {
      Marker marker = Marker(
        markerId: MarkerId(place.name),
        draggable: false,
        //icon: place.icon,
        infoWindow: InfoWindow(title: place.name, snippet: place.vicinity),
        position:
        LatLng(place.geometry.location.lat, place.geometry.location.lng),
      );
      markers.add(marker);
    }
    return markers;
    //return markers.toSet();
  }

  Widget _buildGoogleMap(Position? position, List<Marker> markers) {
    return Expanded(
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          // Optionally animate to initial position
          if (position != null) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14,
                ),
              ),
            );
          }
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
          zoom: 14,
        ),
        markers: markers.toSet(),
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        // Add other Google Map configurations as needed
      ),
    );
  }


  Widget _buildPlacesList(List<Place> places) {
    // Return a widget that displays a list of places
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          height: 156,
          child: PageView.builder(
            itemCount: places.length,
            controller: PageController(viewportFraction: 0.9),
            onPageChanged: (int index) {
              //  ref.read(indexProvider.notifier).state = index;
              ///indexMarker = places[index].placeId;
              var lat = places[index].geometry.location.lat;
              var lng = places[index].geometry.location.lng;

              if (lat != null && lng != null) {
                // var newPosition = ref.read(newPositionProvider);
                newPosition = LatLng(lat, lng);
                newCameraPosition = CameraPosition(
                    target: newPosition, zoom: 17);
                mapController?.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
              }
            },

            itemBuilder: (BuildContext context, int index) {
              return Transform.scale(
                scale: index == _index ? 1 : 0.9,
                child: Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  //  height: 116,
                  //  width:325,
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
                    child:

                     BuildPlaceCard(places[index]! ,  buildPhotoURL: buildPhotoURL)
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BuildPlaceCard extends StatelessWidget {
  //const BuildPlaceCard(Place plac, {Key? key}) : super(key: key);
  final Place place;
  final String Function(String) buildPhotoURL;
  const BuildPlaceCard(this.place, {required this.buildPhotoURL, super.key});


  @override
  Widget build(BuildContext context) {
    /*String imageUrl;
    if (place.photos != null && place.photos!.isNotEmpty) {
      imageUrl = buildPhotoURL(place.photos!.first.photoReference);
    } else {
      imageUrl = 'assets/barbershop02.jpg'; // Fallback to a local asset if no photo is available
    }

    // Safely handle the opening hours text
    String openingHoursText = '운영 시간 정보 없음'; // Default text
    if (place.openingHours != null && place.openingHours!.weekdayText != null) {
      bool isOpenNow = place.openingHours!.openNow ?? false; // Assumes closed if openNow is null
      String todayHours = getTodayHours(place.openingHours!.weekdayText!); // Safely call getTodayHours
      openingHoursText = '${isOpenNow ? '영업 중' : '영업종료'} | $todayHours';
    }*/

    return Row(
      children: <Widget>[
        Expanded(  // 이거 써서 Row 에러 해결.. 그담에 사진...
          child: Padding(
            padding:
            const EdgeInsets.only(
                left: 10,
                top: 7,
                bottom: 27,
                right: 9),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(5.00),
              child: Container(
                height: 126.00,
                width: 106.00,
                decoration: BoxDecoration(
                  image: (place.photos != null && place.photos!.isNotEmpty)
                      ? DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(buildPhotoURL(place.photos![0].photoReference)),
                  )
                      : null, // No image, just the container styling
                  color: (place.photos == null || place.photos!.isEmpty)
                      ? Colors.grey
                      : null, // Set color only if there's no image
                ),
                child: (place.photos == null || place.photos!.isEmpty)
                    //? const Icon(Icons.photo, color: Colors.white)
                  ?     Image.asset(
                    'assets/barbershop02.jpg',
                    fit: BoxFit.fill,
                    height: 250,
                    width: double.infinity,
                  )
                    : null, // Show an icon if there's no image
              ),
            ),
          ),
        ),

        Padding(
          padding:
          const EdgeInsets.only(
              top: 12, right: 1.0),
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
                    place.name,
                    style: TextStyle(
                      fontFamily:
                      "Montserrat",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(
                          0xff000000),
                    ),
                  ),
                  (place.rating != null)
                      ? Row(
                    children: <Widget>[
                      RatingBarIndicator(
                        rating:
                        place.rating,
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
                  Row(
                    children: <Widget>[
                      RatingBarIndicator(
                        rating: 0,
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
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      place
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
                  Container(
                    width: 200,
                    child: Text(
                      // getTodayHours(place.openingHours!.weekdayText!),
                      '${place.openingHours!.openNow != false ? '영업 중' : '영업종료'} | ${getTodayHours(place.openingHours!.weekdayText!) }',
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
                 // _buildInfo(),

                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
           /*ElevatedButton(
          child: Text('목록보기'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (_) => MapListviewScreen()));
                    builder: (_) => MapListviewScreen(places: [], )));
            },
        ),*/
        SizedBox(
          height: 30.0,
        ),
      ],

    );

  }



  Widget _buildInfo() {
    // Safely handle the opening hours
    String openingHoursText = _getOpeningHoursText();

    return Padding(
      padding: const EdgeInsets.only(top: 12, right: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*Text(place.name, style: TextStyle(fontFamily: "Montserrat", fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff000000))),*/
          // Other text and widgets...
          Text(openingHoursText, style: TextStyle(fontFamily: "Montserrat", fontSize: 10, color: Color(0xff000000))),
          // ... other info ...
        ],
      ),
    );
  }

  String _getOpeningHoursText() {
    if (place.openingHours != null && place.openingHours!.weekdayText != null) {
      return getTodayHours(place.openingHours!.weekdayText!);
    } else {
      return 'No hours available';
    }
  }
}

