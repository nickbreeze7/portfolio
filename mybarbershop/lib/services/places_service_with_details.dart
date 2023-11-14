import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/Business.dart';
import '../models/place.dart';

 class PlacesServiceWithDetails    {
  final key = 'AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA';
  //var radius = 1000;

  // final radius = '1500';
  Future<List<Place>> getPlaces  ( double lat, double lng) async {
    http.Response res = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3000&keyword=바버샾&language=ko&type=hair_care|health&rankby=prominence&key=$key'),
      headers: {HttpHeaders.authorizationHeader: key},
    );

    var  data = convert.jsonDecode(res.body)["results"];

   // List<Business> businesses = [];
    List<Place> places = [];

    for (int i = 0; i < data.length; i++) {
      http.Response finalRes = await http.get(
        Uri.parse(
           // 'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&fields=opening_hours%2weekday_text&key=$key&]}'),
            'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&fields=photos,name,formatted_phone_number,type,formatted_address,rating,opening_hours/open_now,opening_hours/weekday_text&key=$key]}'),
        headers: {HttpHeaders.authorizationHeader: key},
      );

      if (finalRes.statusCode == 200) {
        //Place place = Place.fromJson(json.decode(finalRes.body)["result"]);
        var decodedResponse = json.decode(finalRes.body);
        if (decodedResponse["result"] != null) {
          /*
          Place place = Place.fromJson(decodedResponse["result"]);
          places.add(place);
          */
          //Business business = Business.fromJson(decodedResponse["result"]);
          //if (business.openingHours != null) businesses.add(business);
             Place place = Place.fromJson(json.decode(finalRes.body)["result"]);
          // rest of your code
        } else {
          print('No result in the response');
        }
      } else {
        print('Request failed with status: ${finalRes.statusCode}.');
      }
     // if (place.openingHours != null) places.add(place);

    }

    //return businesses;
    return places;
  }
 }
