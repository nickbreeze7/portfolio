import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/barbershop.dart';

class ApiService {
  // 20240719 집에서 테스트 할 때 , 노트북 IP를 baseUrl로 정한다.
  //final String baseUrl9 = 'http://192.168.35.45:3000/api/places';
  // 작심 중앙역 : final String baseUrl9 = 'http://172.30.1.47:3000/api';
  //= 'http://172.30.1.69:3000/barbershops';
  // 작심 산호점 : 172.30.1.69
  // 추후에 클라우드에 db를 넣어서 사용하는 방식으로 고려...
// 천안 집 final String baseUrl999 = 'http://172.30.1.254:3000/barbershops';
  final String baseUrl = 'http://localhost:3000/barbershops';


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
