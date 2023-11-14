import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mybarbershop/models/Business.dart';
import 'package:provider/provider.dart';

import '../../models/place.dart';
import '../../services/geolocator_service.dart';
import '../../services/places_service.dart';
import '../../services/places_service_with_details.dart';
import 'map_search_screen.dart';

// 신규?? -

void main() => runApp(MapScreen());

class MapScreen extends StatelessWidget {
  //const MapScreen({Key? key}) : super(key: key);

  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  final placesServiceWithDetails = PlacesServiceWithDetails();


   MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => locatorService.getLocation(),
          initialData: null,
          // initialData: Future.value(List<Position?>.empty()),
          //initialData: null,
          // initialData: [],
        ),
        /*  FutureProvider(
          create: (context) {
            ImageConfiguration configuration =
                createLocalImageConfiguration(context);
            return BitmapDescriptor.fromAssetImage(
                configuration, 'assets/selectedMarker.png');
          },
          initialData:null,
          //initialData: [],
          // initialData: Future.value(List<BitmapDescriptor?>.empty()),
          //initialData: null,
        ),*/
        //ProxyProvider2<Position?, BitmapDescriptor?, Future<List<Place>>?>(
        ProxyProvider<Position?, Future<List<Place>>?>(
          // update: (context, position, icon, places) {
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
               // ? placesServiceWithDetails.getPlaces(position.latitude, position.longitude)
                : null;
          },
           //  update: (context, position, icon, places) {
            //update: (context, position, places) {
          /*  return (position != null)
                ? placesService.getPlaces(
                    //  position.latitude, position.longitude)
                    position.latitude,
                    position.longitude,
                    icon!)
                : Future.value([]);
          },*/
        ),
        // Business로 적용해 봤는데, 잘안됨.. 20231108
       /* ProxyProvider<Position?, Future<List<Business>>?>(

          update: (context, position, places) {
            return (position != null)
                ? placesServiceWithDetails.getPlaces(position.latitude, position.longitude)
                : null;
          },
        ),*/
     /*   ProxyProvider<Position?, Future<List<Place>>?>(
          update: (context, position, places) {
            return (position != null)
                ? placesServiceWithDetails.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )*/
      ],
      child: MaterialApp(
        title: '우리동네 바버샾',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MapSearchScreen(),
      ),
    );
  }
}
