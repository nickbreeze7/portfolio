class Location{
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  Location.fromJson(Map<dynamic,dynamic> parsedJson)
      :lat = parsedJson['lat'],
      lng = parsedJson['lng'];
}