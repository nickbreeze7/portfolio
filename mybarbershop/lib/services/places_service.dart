import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/place.dart';


class PlacesService {

  // Google Api
  final key = 'AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA';

/*
  Future<List<Place>>  getPlaces999(double lat, double lng, double radius) async {
    http.Response res = await http.get(
      Uri.parse(
       //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&keyword=바버,barber&type=hair_care|health&rankby=prominence&key=$key'),
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&keyword=바버,barber&type=hair_care|health&rankby=prominence&key=$key'),
    headers: {HttpHeaders.authorizationHeader: key},
    );
    var data = convert.jsonDecode(res.body)["results"] as List;
    List<Place> places = [];

    for (int i = 0; i < data.length; i++) {
      http.Response finalRes = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&key=$key'),
        headers: {HttpHeaders.authorizationHeader: key},
      );
      // Place place = Place.fromJson(jsonResults1 as Map<String, dynamic>);
      //Place place =  Place.fromJson(data[i]);
      Place place = Place.fromJson(convert.jsonDecode(finalRes.body)["result"]);
      if (place.openingHours != null) places.add(place);
    }
    // return data.map((place) => Place.fromJson(place)).toList();
    return places;
  }
*/

  Future<List<Place>> getPlaces(double lat, double lng, double radius) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&keyword=바버|barber&language=ko&type=hair_care|health&rankby=prominence&key=$key'),
        headers: {HttpHeaders.authorizationHeader: key},
      );
      var data = convert.jsonDecode(res.body)["results"] as List;
      List<Place> places = [];

      for (int i = 0; i < data.length; i++) {
        http.Response finalRes = await http.get(
          Uri.parse(
              'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&key=$key'),
          headers: {HttpHeaders.authorizationHeader: key},
        );
        // Place place = Place.fromJson(jsonResults1 as Map<String, dynamic>);
        //Place place =  Place.fromJson(data[i]);
        Place place = Place.fromJson(
            convert.jsonDecode(finalRes.body)["result"]);
        if (place.openingHours != null) places.add(place);
      }
      return data.map((place) => Place.fromJson(place)).toList();
     // return places;
    } catch (e) {
      throw Exception('Error fetching places:>>>>>>>>>>>>>>>>>>> $e');
    }
  }


  Future<List<Review>> fetchPlaceReviews(String placeId) async {
    final apiKey = 'AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA'; // Replace with your Google Places API key
    final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=reviews&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> reviewsJson = jsonResponse['result']['reviews'];

      List<Review> reviews = reviewsJson.map((json) => Review.fromJson(json))
          .toList();

      return reviews;
    } else {
      throw Exception('Failed to load place reviews');
    }
  }
}
/*

  Future<List<Review>> fetchPlaceReviews999(double lat, double lng, double radius) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&keyword=바버|barber&type=hair_care|health&rankby=prominence&key=$key'),
        headers: {HttpHeaders.authorizationHeader: key},
      );
      var data = convert.jsonDecode(res.body)["results"] as List;
      List<Review> reviews = [];

      for (int i = 0; i < data.length; i++) {
        http.Response finalRes = await http.get(
          Uri.parse(
              'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&fields=reviews&key=$key'),
          headers: {HttpHeaders.authorizationHeader: key},
        );

        if (finalRes.statusCode == 200) {
          final jsonResponse = json.decode(finalRes.body);
          final List<dynamic> reviewsJson = jsonResponse['result']['reviews'];

          List<Review> placeReviews = reviewsJson.map((json) =>
              Review.fromJson(json)).toList();
          reviews.addAll(placeReviews);
        } else {
          throw Exception('Failed to load place reviews');
        }
      }

      return reviews;
    } catch (e) {
      throw Exception('Error fetching places: $e');
    }
  }
}
*/

