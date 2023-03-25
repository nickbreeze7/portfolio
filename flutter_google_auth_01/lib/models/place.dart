import 'package:flutter_google_auth_01/models/photos.dart';

import 'geometry.dart';

class Place {
  final String name;
  final double rating;
  final int userRatingCount;
  final String vicinity;
  final Geometry geometry;
  final String placeId;
  final List<Photos>? photos;
  //final BitmapDescriptor icon;

  /*
  String latitude;
  String longitude;
  int id;
  String description;
  String image;
 */
  //final BitmapDescriptor icon;
  //final List<Photo> photos;
  Place(
      {required this.name,
      required this.rating,
      required this.userRatingCount,
      required this.vicinity,
      required this.geometry,
      required this.placeId,
      required this.photos
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
            : null;
  //icon = icon;
}
/*
        photos = (parsedJson['photos'] != null)
            ? parsedJson['photos']
                .map<Photo>((json) => Photo.fromJson(json))
                .toList()
            : null,
         */
