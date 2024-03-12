
import 'dart:core';
import 'dart:io';
import 'package:flutter/Material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybarbershop/models/photos.dart';
import 'package:mybarbershop/screens/book/barbershop_detail_screen_bak2.dart';
import '../screens/book/barbershop_detail_screen_bak_original.dart';
import '../screens/book/barbershop_detail_screen.dart';
import '../screens/book/barbershop_detail_screen_Str_line.dart';
import '../services/geolocator_service.dart';
import '../services/getTodayHours.dart';

import '../services/places_service.dart';
import '../utils/providers_home.dart';
import 'geometry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


final placesProvider = FutureProvider<List<Place>>((ref) async {
  final geoLocatorService = GeoLocatorService();
  final position = await geoLocatorService.getLocation();
  final double kmRange = ref.watch(kilometerProvider);
  print('Place_kmRange:=============================>>> $kmRange');
  var radius = kmRange * 1000;  // Convert km to meters
  print('Place_radius:=============================>>> $radius');
  final placesService = PlacesService();

  try {
    return await placesService.getPlaces(position.latitude, position.longitude, radius);

  } catch (e) {
    // Handle any errors that might occur during fetching places
    throw Exception('Place_Failed to fetch places:>>>> $e');
  }
});


const kGoogleApiKey = 'AIzaSyDGPBoY_wVMpu1Uci3IYHGNBJUYWxljOpA';
String buildPhotoURL(String photoReference) {
  return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=350&photoreference=$photoReference&key=$kGoogleApiKey";
}



class LocationTest extends ConsumerWidget {
  const LocationTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAPI = ref.watch(placesProvider);
    return Column(
      children: [
        locationAPI.when(
          data: (places) {
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: Card(
                color:Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 5.0,
                child: Column(
                  children: [
                    ClipRRect(
                      /*borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),*/
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                      child: SizedBox(
                        height:450,
                        width: double.infinity,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: places.length,
                            // 얘 때문에 전부 다 채워짐!!! 20240203
                            controller: PageController(viewportFraction: 1.0),
                            itemBuilder: (context, index) {
                              List<Widget> widgets = []; // This is your list of widgets
                              if (places[index].photos != null) {
                                widgets.add(
                                  Image.network(
                                    buildPhotoURL(places[index].photos![0].photoReference),
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                );
                              } else {
                                widgets.add(
                                  Image.asset(
                                    'assets/barbershop02.jpg',
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                );
                              }

                              // 원본 20231104
                              widgets.add(
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        places[index].name,
                                        style: const TextStyle(fontSize: 25),

                                      ),
                                      RatingBar.builder(
                                        initialRating: places[index].rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          places[index].vicinity,
                                          style: const TextStyle(fontSize: 15)
                                      ),
                                      //  if (places[index].openingHours != null && places[index].openingHours!.weekdayText != null)
                                      Text(
                                          '${places[index].openingHours?.openNow != false ? '영업 중' : '영업종료'} | ${getTodayHours(places[index].openingHours!.weekdayText!) }',
                                          style: const TextStyle(fontSize: 15)
                                      ),
                                      SizedBox(height: 40),

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:Size.fromHeight(50),
                                            primary: Colors.black,
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: Text('예약하기',
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed:(){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                               //    builder: (_) =>  BarbershopDetailScreen(placeId: places[index].placeId)));
                                            builder: (_) =>  BarbershopDetailScreen(placeId: places[index].placeId)));
                                               //builder: (_) =>  BarbershopDetailScreenStrline(placeId: places[index].placeId)));

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              return Column(
                                children: widgets,
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ],
    );
  }
}




  Widget _buildTextForPlace(Place place) {
    if (place.openingHours == null || place.openingHours!.weekdayText == null) {
      return const Text('No opening hours available');
    }
    String todayHours = getTodayHours(place.openingHours!.weekdayText!);

    // Handle the null case for openNow
    String openStatus = 'Data not available';
    if (place.openingHours!.openNow != null) {
      openStatus = place.openingHours!.openNow! ? '영업 중' : '영업종료';
    }

    return Text('$openStatus | $todayHours');
  }




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
            ? OpeningHours.fromJson(parsedJson['opening_hours'])
            : null,
        formattedAddress = (parsedJson['formatted_address'] != null)
            ? parsedJson['formatted_address']
            : null,
        formattedPhoneNumber = (parsedJson['formatted_phone_number'] != null)
            ? parsedJson['formatted_phone_number']
            : null,
        types = (parsedJson['types'] != null) ? parsedJson['types'] : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (formattedAddress != null) {
      data['formatted_address'] = formattedAddress;
    }
    if (formattedPhoneNumber != null) {
      data['formatted_phone_number'] = formattedPhoneNumber;
    }
    data['name'] = name;
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.toJson();
    }
    data['types'] = types;
    return data;
  }
}


class OpeningHours {
  bool? openNow;
  List<String>? weekdayText;

  OpeningHours({required this.openNow, required this.weekdayText});

  OpeningHours.fromJson(Map<String, dynamic> parsedJson) {
    openNow = parsedJson['open_now'];
    weekdayText = parsedJson['weekday_text'] != null ?
    List<String>.from(parsedJson['weekday_text']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open_now'] = openNow;
    data['weekday_text'] = weekdayText;
    return data;
  }
}

class Review {
  final String authorName;
  final double rating;
  final String text;
  final int time;

  Review( {required this.authorName, required this.rating, required this.text, required this.time});

  factory Review.fromJson(Map<String, dynamic> json) {
    int timeInMillis = (json['time'] * 1000).toInt();
    return Review(
      authorName: json['author_name'],
      rating: json['rating'].toDouble(),
      text: json['text'],
      time:timeInMillis,
    );
  }
}
