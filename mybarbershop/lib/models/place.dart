
import 'dart:core';
import 'dart:io';
import 'package:flutter/Material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mybarbershop/models/photos.dart';
import '../services/geolocator_service.dart';
import '../services/getTodayHours.dart';
import '../services/places_service.dart';
import 'Business.dart';
import 'geometry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:convert';



final  placesProvider = FutureProvider<List<Place>>((ref) async {

  // final response = await http.get(
  final key = 'AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA';
  var radius = 1000;
  final placesService = PlacesService();
  final locatorService = GeoLocatorService();
  var currentPositionProvider = locatorService.getLocation();

  //final position = ref.watch(currentPositionProvider);
  final position = await currentPositionProvider;
  print('position:=============================>>> $position');

  final lat = position.latitude;
  print('lat:=============================>>> $lat');

  final lng = position.longitude;
  print('lng:=============================>>> $lng');


  http.Response response = await http.get(Uri.parse(
     // 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&keyword=바버샾&language=ko&type=hair_care|health&rankby=distance&key=$key'),
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3000&keyword=바버샾&language=ko&type=hair_care|health&rankby=prominence&key=$key'),
      headers: {HttpHeaders.authorizationHeader: key}
  );

  //print('response:=============================>>> $response');

  //var json = convert.jsonDecode(response.body);
 // print('json:=============================>>> $json');

 // var jsonResults = json['results'] as List;
 // print('jsonResults:=============================>>> $jsonResults');
  var data = convert.jsonDecode(response.body)["results"] as List;

  List<Place> places = [];

  for (int i = 0; i < data.length; i++) {
    http.Response finalRes = await http.get(
      Uri.parse(
        // 'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&fields=name,formatted_phone_number,type,formatted_address,rating,opening_hours/open_now,opening_hours/weekday_text&key=$key'),
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=${data[i]["place_id"]}&key=$key'),
          headers: {HttpHeaders.authorizationHeader: key},
    );

    // Place place = Place.fromJson(jsonResults1 as Map<String, dynamic>);
    //Place place =  Place.fromJson(data[i]);
    Place place = Place.fromJson(convert.jsonDecode(finalRes.body)["result"]);

    if (place.openingHours != null) places.add(place);
  }

  if (response.statusCode == 200) {

    //print('jsonResults:=============================>>> $jsonResults');
    //return jsonResults.map((place) => Place.fromJson(place)).toList();
    return places;

  } else {
    throw Exception('Failed to load places');
  }
});

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

  Place(
      {required this.name,
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
            ? parsedJson['rating'].toDouble() ?? 0.0 : 0.0,

      userRatingCount = (parsedJson['user_ratings_total'] != null)
          ? parsedJson['user_ratings_total'] as int: 0,

        vicinity = parsedJson['vicinity'],
        geometry = Geometry.fromJson(parsedJson['geometry']),
        placeId = parsedJson['place_id'],

        photos = (parsedJson['photos'] != null)
            ? parsedJson['photos']
                .map<Photos>((parsedJson) => Photos.fromJson(parsedJson))
                .toList() : null,
          //<== 여기에 7개가 들어가야 되는데, 3개밖에 못담김...왜??? 20231025

        businessStatus = (parsedJson['business_status'] != null)
            ? parsedJson['business_status']
            : null,
        openingHours = parsedJson['opening_hours'] != null
            ? new OpeningHours.fromJson(parsedJson['opening_hours'])
            : null,
        /*openingHours = OpeningHours.fromJson(parsedJson['opening_hours']),*/
        formattedAddress = (parsedJson['formatted_address'] != null)
            ? parsedJson['formatted_address']
            : null,
        formattedPhoneNumber = (parsedJson['formatted_phone_number'] != null)
            ? parsedJson['formatted_phone_number']
            : null,
        types = (parsedJson['types'] != null) ? parsedJson['types'] : null;

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

final kGoogleApiKey = 'AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA';
String buildPhotoURL(String photoReference) {
  //return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${kGoogleApiKey}";
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=250&photoreference=${photoReference}&key=${kGoogleApiKey}";
}

int _index = 0;
//List<Widget> widgets = [];

Future<List<Place>> place = Future.value([]);
//Future<List<Business>> businesses = Future.value([]);

class LocationTest extends ConsumerWidget {
  const LocationTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAPI = ref.watch(placesProvider);
    return Column(
      children: [
        locationAPI.when(data: (places) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4.0,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: SizedBox(
                      height: 480,
                      width: 600,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: places.length,
                        controller:  PageController(viewportFraction: 0.9),
                       /*   onPageChanged: (int index) {
                            //markers
                            setState(() => _index = index
                            );
                          }*/
                        //  onPageChanged: (int index) => setState(() => _index = index),


                          itemBuilder: (context, index) {
                            List<Widget> widgets = []; // This is your list of widgets
                            if (places[index].photos != null) {
                              widgets.add(
                                Image.network(
                                  buildPhotoURL(places[index].photos![0].photoReference),
                                  fit: BoxFit.fill,
                                  height: 150,
                                  width: double.infinity,
                                ),
                              );
                            } else {
                              widgets.add(
                                Image.asset(
                                  'assets/barbershop02.jpg',
                                  fit: BoxFit.fill,
                                  height: 150,
                                  width: double.infinity,
                                ),
                              );
                            }

                            // 원본 20231104
                            widgets.add(
                              ListTile(
                                title: Text(
                                  places[index].name,
                                  style: TextStyle(fontSize: 20),
                                ),
                                trailing: RatingBar.builder(
                                  initialRating: places[index].rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(places[index].vicinity,
                                        style: TextStyle(fontSize: 15)),
                                  Text(
                                      //${places[index].openingHours?.openNow != false ? '영업 중' : '영업종료'} | ${places[index].openingHours?.weekdayText != null ? getTodayHours(places[index].openingHours!.weekdayText!) : 'No hours available'}',
                                      '${places[index].openingHours?.openNow != false ? '영업 중' : '영업종료'} | ${places[index].openingHours?.weekdayText != null ? getTodayHours(places[index].openingHours!.weekdayText!) : 'No hours available'}',

                                      style: TextStyle(fontSize: 15)),
                                  ],
                                    ),
                              ),
                            );

                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widgets, // Use the list of widgets here
                              ),
                            );
                          }   //itembuilder !!!!

                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }, loading: () {
          return const CircularProgressIndicator();
        }, error: (e, s) {
          return Text(e.toString());
        }),
      ],
    );
  }
}

class OpeningHours {
  bool? openNow;
  List<String>? weekdayText;

  OpeningHours({required this.openNow, required this.weekdayText});

  OpeningHours.fromJson(Map<String, dynamic> parsedJson) {
    openNow = parsedJson['open_now'];
    // weekdayText = parsedJson['weekday_text'].cast<String>().toList();
    weekdayText = parsedJson['weekday_text'] != null
        ? parsedJson['weekday_text'].cast<String>()
        : null;
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
