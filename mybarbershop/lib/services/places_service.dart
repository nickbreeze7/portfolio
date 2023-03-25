import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../models/place.dart';

class PlacesService {
  final key = 'Your Key';
  var radius = 1000;
 // final radius = '1500';
  Future<List<Place>> getPlaces(
      //  double lat, double lng, BitmapDescriptor icon) async {
      double lat,
      double lng
      ) async {

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3000&keyword=바버샾&language=ko&type=hair_care|health&rankby=prominence&key=$key');

    //    'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=바버샾&location=$lat,$lng&language=ko&type=hair_care|health&rankby=distance&key=$key');
    //   'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&rankby=distance&keyword=바버샾&language=ko&type=hair_care|health&key=$key');
    //    'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3000&keyword=바버&language=ko&type=hair_care|health|point_of_interest|establishment&rankby=prominence&key=$key');


    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    // return jsonResults.map((place) => Place.fromJson(place, icon)).toList();
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
