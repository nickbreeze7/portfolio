
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

 
}
