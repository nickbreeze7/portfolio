class Location {
  final double lat;
  final double lng;
  //final double radius;

  //Location({required this.lat, required this.lng, required this.radius});
  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<dynamic, dynamic> parsedJson) {
//    return Location(lat: parsedJson['lat'], lng: parsedJson['lng'],radius: parsedJson['radius']);
    return Location(lat: parsedJson['lat'], lng: parsedJson['lng']);

  }
}
