import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/barbershop.dart';

class ApiService {
 // final String baseUrl999 = 'http://localhost:3000/barbershops';
  //https://barbershop2-5a51a1029617.herokuapp.com/
  final String baseUrl = 'https://barbershop2-5a51a1029617.herokuapp.com/barbershops';


  Future<List<Barbershop>> getBarbershops(double latitude, double longitude) async {
    Uri url = Uri.parse('$baseUrl?lat=$latitude&lng=$longitude');
    log('Fetching barbershop data: $url');

    try {
      var response = await http.get(url);
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body) as List;
        return decodedJson.map((item) => Barbershop.fromJson(item)).toList();
      } else {
        log('Failed to load with status code: ${response.statusCode}');
        throw Exception('Failed to load barbershops with status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching barbershops: $e');
      throw Exception('Error fetching barbershops: $e');
    }
  }
}
