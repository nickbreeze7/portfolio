import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/place.dart';

class PlacesService {
  final key = 'AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA';
  var radius = 1000;

  // final radius = '1500';
  Future<List<Place>> getPlaces(
      //  double lat, double lng, BitmapDescriptor icon) async {
      double lat,
      double lng) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3000&keyword=바버샾&language=ko&type=hair_care|health&rankby=prominence&key=$key');
    //    'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=바버샾&location=$lat,$lng&language=ko&type=hair_care|health&rankby=distance&key=$key');
    //   'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&rankby=distance&keyword=바버샾&language=ko&type=hair_care|health&key=$key');
    //    'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3000&keyword=바버&language=ko&type=hair_care|health|point_of_interest|establishment&rankby=prominence&key=$key');

    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;



    for (int i = 0; i < jsonResults.length; i++) {
      http.Response finalRes = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/details/json?place_id=${jsonResults[i]["place_id"]}&fields=name,formatted_phone_number,type,formatted_address,rating,opening_hours/open_now,opening_hours/weekday_text&key=$key'),
        headers: {HttpHeaders.authorizationHeader: key},
      );
      Place places = Place.fromJson(json.decode(finalRes.body)["result"]);
      if (places.openingHours != null)
        places.openingHours!.openNow = json.decode(finalRes.body)["result"]["opening_hours"]["open_now"];
        //return jsonResults.map((place) => Place.fromJson(place)).toList();
    }
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
