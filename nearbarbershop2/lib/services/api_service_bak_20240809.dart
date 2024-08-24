import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/barbershop.dart';

class ApiService999 {

  final String baseUrl = 'http://192.168.35.45:3000/barbershops';

  Future<List<Barbershop>> getBarbershops() async {
    Uri url = Uri.parse(baseUrl);
    log( 'url ================================: $url');

    var response = await http.get(url);
    log( 'response ================================: $response');
    log('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      if (decodedJson is Map) {
        // It's a single object, wrap it in a list
        return [Barbershop.fromJson(decodedJson as Map<String, dynamic>)];
      } else if (decodedJson is List) {
        // It's actually a list of objects
        return decodedJson.map((item) => Barbershop.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      log('Failed to load with status code: ${response.statusCode}');
      throw Exception('Failed to load barbershops with status code: ${response.statusCode}');
    }
  }



}
