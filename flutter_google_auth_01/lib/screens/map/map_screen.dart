import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../models/place.dart';
import '../../services/geolocator_service.dart';
import '../../services/places_service.dart';
import 'map_search_screen.dart';

// 신규?? -
const kGoogleApiKey = 'AIzaSyCF40kZoFy6eQPMrqAbejKTDVnI3X3MKRI';
//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapScreen extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
            create: (context) => locatorService.getLocation(),
            initialData: null //null -> []로 하면 에러발생!!!
            ),
        ProxyProvider<Position?, Future<List<Place>>?>(
          update: (context, position, places) {
            if ((position != null)) {
              return placesService.getPlaces(
                  position.latitude, position.longitude);
            } else {
              return null;
            }
          },
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
