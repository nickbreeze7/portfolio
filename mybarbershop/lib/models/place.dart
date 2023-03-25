import 'package:mybarbershop/models/photos.dart';

import 'geometry.dart';
import 'openinghours.dart';

class Place {
   final String name;
   final double rating;
   final int userRatingCount;
   final String vicinity;
   final Geometry geometry;
   final String placeId;
   final List<Photos>? photos;
   final String businessStatus;
   final OpeningHours? openingHours;

  //final BitmapDescriptor icon;

  Place(
      {required this.name,
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
        //openingHours = OpeningHours.fromJson(parsedJson['opening_hours']);
  /* openingHours = (parsedJson['opening_hours'] != null)
   ? parsedJson['opening_hours']
       : false;*/
   openingHours = parsedJson['opening_hours'] != null
   ?  OpeningHours.fromJson(parsedJson['opening_hours'])
       : null;


  /*Place.fromJson(Map<dynamic, dynamic> parsedJson) {
    name = parsedJson['name'];
    rating =
        (parsedJson['rating'] != null) ? parsedJson['rating'].toDouble() : null;
    userRatingCount = (parsedJson['user_ratings_total'] != null)
        ? parsedJson['user_ratings_total']
        : null;
    vicinity = parsedJson['vicinity'];
    geometry = Geometry.fromJson(parsedJson['geometry']);
    placeId = parsedJson['place_id'];
    if (parsedJson['photos'] != null) {
      photos = <Photos>[];
      //photos = [];
      parsedJson['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
  }
*/
/*
        photos = (parsedJson['photos'] != null)
            ? parsedJson['photos']
                .map<Photo>((json) => Photo.fromJson(json))
                .toList()
            : null,
         */
}
