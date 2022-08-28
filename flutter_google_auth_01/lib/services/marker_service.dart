import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MarkerService {
  Future<List<Marker>> getMarkers(List<Place> places) async {
    //final Set<Marker> _markers = {};
    //var _markers = List<Marker>();
    //var markers = <Marker>[];
    final List<Marker> markers = [];

    places.forEach((place) {
      Marker marker = Marker(
          markerId: MarkerId(place.name),
          draggable: false,
          infoWindow: InfoWindow(title: place.name, snippet: place.vicinity),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng));
      markers.add(marker);
    });
    return markers;
  }
}
