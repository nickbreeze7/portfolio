import 'package:mybarbershop/models/location.dart';

class Geometry {
  final Location location;

  Geometry({required this.location});

  Geometry.fromJson(Map<String, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
}
