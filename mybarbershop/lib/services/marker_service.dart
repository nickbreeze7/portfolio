import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MarkerService {
  // Future<List<Marker>> ===> List<Marker>로 하니까, 나옴!!!

  List<Marker> getMarkers(List<Place> places) {
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
  }
}
