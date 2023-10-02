import 'dart:core';
import 'package:mybarbershop/models/photos.dart';
import 'geometry.dart';


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
  String? formattedAddress;
  String? formattedPhoneNumber;
  List<dynamic> types;

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
    required this.openingHours,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.types
    //required this.icon
  });

  //https://github.com/bazrafkan/google_place/tree/master/lib/src/models 참조!!!
  // Place.fromJson(Map<dynamic, dynamic> parsedJson, BitmapDescriptor icon)
  Place.fromJson(Map<String, dynamic> parsedJson)
      : name = parsedJson['name'],
        rating = (parsedJson['rating'] != null)
            ? parsedJson['rating'].toDouble()
            : null,
        userRatingCount = (parsedJson['user_ratings_total'] != null)
            ? parsedJson['user_ratings_total']
            : null,
  /* userRatingCount = parsedJson['user_ratings_total'],*/
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
            ?  new OpeningHours.fromJson(parsedJson['opening_hours'])
            : null,
  /*openingHours = OpeningHours.fromJson(parsedJson['opening_hours']),*/
        formattedAddress = (parsedJson['formatted_address'] != null)
            ? parsedJson['formatted_address']
            : null,
        formattedPhoneNumber = (parsedJson['formatted_phone_number'] != null)
            ? parsedJson['formatted_phone_number']
            : null,
        types =  (parsedJson['types'] != null)
            ? parsedJson['types']
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.formattedAddress != null) {
      data['formatted_address'] = this.formattedAddress;
    }
    if (this.formattedPhoneNumber != null) {
      data['formatted_phone_number'] = this.formattedPhoneNumber;
    }
    data['name'] = this.name;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours!.toJson();
    }
    if (this.types != null) {
      data['types'] = this.types;
    }
    return data;
  }
}
class OpeningHours {
  bool? openNow;
  List<String>? weekdayText;

  OpeningHours({
    required this.openNow,
    required this.weekdayText});

  OpeningHours.fromJson(Map<String, dynamic> parsedJson) {
    openNow = parsedJson['open_now'];
    // weekdayText = parsedJson['weekday_text'].cast<String>().toList();
    weekdayText = parsedJson['weekday_text'] != null ?  parsedJson['weekday_text'].cast<String>() :  [];
    // weekdayText =  List<String>.from(parsedJson['weekday_text'].map((x) => x));
    // weekdayText = parsedJson['weekday_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open_now'] = this.openNow;
    data['weekday_text'] = this.weekdayText;
    return data;
  }
}