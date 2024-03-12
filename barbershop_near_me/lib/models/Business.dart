
import 'package:mybarbershop/models/photos.dart';

class Business {
  List<Photos>? photos;
  String? formattedAddress;
  String? formattedPhoneNumber;
  String? name;
  OpeningHours? openingHours;
  List<dynamic>? types;

  Business({
    required this.photos,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.name,
    required this.openingHours,
    required this.types,
  });

  Business.fromJson(Map<String, dynamic> json) {
    photos = (json['photos'] != null) ? json['photos']
        .map<Photos>((parsedJson) => Photos.fromJson(parsedJson))
        .toList() : null;

    formattedAddress = json['formatted_address'] != null
        ? formattedAddress = json['formatted_address']
        : null;
    formattedPhoneNumber = json['formatted_phone_number'] != null
        ? formattedPhoneNumber = json['formatted_phone_number']
        : null;
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    types = json['types'] != null ? types = json['types'] : null;
  }

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
    if (types != null) {
      data['types'] = types;
    }
    return data;
  }
}

class OpeningHours {
  bool? openNow;
  List<String>? weekdayText;

  OpeningHours({required this.openNow, required this.weekdayText});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
    weekdayText = json['weekday_text'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open_now'] = openNow;
    data['weekday_text'] = weekdayText;
    return data;
  }
}