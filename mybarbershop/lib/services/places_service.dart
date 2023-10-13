import 'dart:convert' as convert;
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/place.dart';

 class PlacesService    {
  // Google Api
  final key = 'XXXXXXXXXXXXXXXXXXXXXX';
  var radius = 1000;

  // final radius = '1500';
  Future<List<Place>> getPlaces  ( double lat, double lng) async {
    /*var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3000&keyword=바버샾&language=ko&type=hair_care|health&rankby=prominence&key=$key');
     */
     http.Response res = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3000&keyword=바버샾&language=ko&type=hair_care|health&rankby=prominence&key=$key'),
      headers: {HttpHeaders.authorizationHeader: key},
    );

    /*  var response = await http.get(url);
        var json = convert.jsonDecode(response.body);
        var jsonResults = json['results'] as List;
    */
     dynamic data = convert.jsonDecode(res.body)["results"];
    // var  data = convert.jsonDecode(res.body)["results"] as List;

    List<Place> places = [];

    for (int i = 0; i < data.length; i++) {
      http.Response finalRes = await http.get(
        Uri.parse(
            //'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}& key=$key'),
          //   'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&key=$key'),
        // 'https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJfX3Rk2ZDezURhy8WJs5cA_0&fields=opening_hours&key=AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA'),
        //  'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&fields=opening_hours/weekday_text&key=$key'),
            'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&fields=opening_hours%2weekday_text&key=$key&]}'),
        headers: {HttpHeaders.authorizationHeader: key},
      );
      /*Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=${jsonResults1[i]["place_id"]}&fields=name,formatted_phone_number,type,formatted_address,rating,opening_hours/open_now,opening_hours/weekday_text&key=$key');
      var response1 = await http.get(url);
      var json = convert.jsonDecode(response1.body);
      var jsonResults1 = json['results'] as List;
    */
      // Place place = Place.fromJson(jsonResults1 as Map<String, dynamic>);
      //Place place = Place.fromJson(json.decode(finalRes.body)["result"]);
      Place place =  Place.fromJson(data[i]);

      if (place.openingHours != null) places.add(place);
      print('place:=============================>>> $place');
    }

    // return data.map((place) => Place.fromJson(place)).toList();
    return places;
  }
}
