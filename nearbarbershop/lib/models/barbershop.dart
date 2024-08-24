import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'barbershop.g.dart';

@JsonSerializable()
class Barbershop {
  final int id;
  final String name;
  final String address;
  final double x; // latitude
  final double y; // longitude



  Barbershop({
    required this.id,
    required this.name,
    required this.address,
    required this.x,
    required this.y,
  });

  // Method to `fromJson` is useful for decoding an instance of `Barbershop` from a map

  factory Barbershop.fromJson(Map<String, dynamic> json) {
    return Barbershop(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      x: json['x'] != null ? double.tryParse(json['x'].toString()) ?? 0.0 : 0.0,
      y: json['y'] != null ? double.tryParse(json['y'].toString()) ?? 0.0 : 0.0,
    );

  }


  // Method to `toJson` is useful for encoding an instance of `Barbershop` to a map
  Map<String, dynamic> toJson() => _$BarbershopToJson(this);

}

