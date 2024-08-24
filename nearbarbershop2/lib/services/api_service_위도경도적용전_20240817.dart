import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/barbershop.dart';

class ApiService9999 {
  // 이주소는 집에서 할 때, 실IP로 해야지 정보를 받아온다.
  //final String baseUrl99999 = 'http://192.168.35.45:3000/barbershops';// Adjust as needed
// 작심 중앙역 : final String baseUrl9 = 'http://172.30.1.47:3000/barbershops';
  //final String baseUrl000 = 'http://192.168.35.45:3000/barbershops';// Adjust as needed
  //final String baseUrl99 = 'http://172.30.1.47:3000/barbershops';

  //final String baseUrl999 = 'http://192.168.35.2:3000/barbershops';


  final String baseUrl = 'http://172.30.1.47:3000/barbershops';

  Future<List<Barbershop>> getBarbershops() async {
    Uri url = Uri.parse(baseUrl);
    log('Fetching barbershops from: $url');

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
