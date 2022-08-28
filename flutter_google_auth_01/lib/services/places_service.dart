import 'dart:convert' as convert;

import 'package:flutter_google_auth_01/models/place.dart';
import 'package:http/http.dart' as http;

class PlacesService {
  final key = 'AIzaSyCF40kZoFy6eQPMrqAbejKTDVnI3X3MKRI';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=바버샾&location=$lat,$lng&type=hair_care|health&rankby=distance&key=$key');

    try {
      var response = await http.get(url);
      var json = convert.jsonDecode(response.body);
      var jsonResults = json['results'] as List;
      return jsonResults.map((place) => Place.fromJson(place)).toList();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
    //return null;
  }
}
