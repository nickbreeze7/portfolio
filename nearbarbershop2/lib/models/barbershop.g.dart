// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barbershop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Barbershop _$BarbershopFromJson(Map<String, dynamic> json) => Barbershop(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      tel: json['tel'] as String,
      thumUrl: json['thumUrl'] as String,
      bizhourInfo: json['bizhourInfo'] as String,
    );

Map<String, dynamic> _$BarbershopToJson(Barbershop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'x': instance.x,
      'y': instance.y,
      'tel': instance.tel,
      'thumUrl': instance.thumUrl,
      'bizhourInfo': instance.bizhourInfo,

    };
