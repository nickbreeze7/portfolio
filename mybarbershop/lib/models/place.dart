import 'dart:core';
import 'package:mybarbershop/models/photos.dart';
import 'geometry.dart';
import 'openinghours.dart';

class Place {
  String name;
  double rating;
  int userRatingCount;
  String vicinity;
  Geometry geometry;
  String placeId;
  List<Photos>? photos;
  String businessStatus;
  OpeningHours? openingHours;


  //final BitmapDescriptor icon;

  Place({
    required this.name,
    required this.rating,
    required this.userRatingCount,
    required this.vicinity,
    required this.geometry,
    required this.placeId,
    required this.photos,
    required this.businessStatus,
    required this.openingHours

    //required this.icon
  });

  //https://github.com/bazrafkan/google_place/tree/master/lib/src/models 참조!!!
  // Place.fromJson(Map<dynamic, dynamic> parsedJson, BitmapDescriptor icon)
  Place.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        rating = (parsedJson['rating'] != null)
            ? parsedJson['rating'].toDouble()
            : null,
        userRatingCount = (parsedJson['user_ratings_total'] != null)
            ? parsedJson['user_ratings_total']
            : null,
        vicinity = parsedJson['vicinity'],
        geometry = Geometry.fromJson(parsedJson['geometry']),
        placeId = parsedJson['place_id'],
        photos = (parsedJson['photos'] != null)
            ? parsedJson['photos']
            .map<Photos>((parsedJson) => Photos.fromJson(parsedJson))
            .toList()
            : [],
        businessStatus = (parsedJson['business_status'] != null)
            ? parsedJson['business_status']
            : null,
        openingHours = parsedJson['opening_hours'] != null
            ? OpeningHours.fromJson(parsedJson['opening_hours'])
            : null;


}