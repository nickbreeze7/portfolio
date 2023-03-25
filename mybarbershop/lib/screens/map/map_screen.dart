import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../models/place.dart';
import '../../services/geolocator_service.dart';
import '../../services/places_service.dart';
import 'map_search_screen.dart';

// 신규?? -

void main() => runApp(MapScreen());

//const MapScreen({Key? key}) : super(key: key);

class MapScreen extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

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
                : null;
          },
          /*  update: (context, position, icon, places) {
            //update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(
                    //  position.latitude, position.longitude)
                    position.latitude,
                    position.longitude,
                    icon!)
                : Future.value([]);
          },*/
        )
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
