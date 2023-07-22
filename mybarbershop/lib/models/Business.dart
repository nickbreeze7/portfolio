class Business {
  late  String? formattedAddress;
  late  String? formattedPhoneNumber;
  late  String? name;
  late  OpeningHours? openingHours;
  late  List<dynamic>? types;

  Business({
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.name,
    required this.openingHours,
    required this.types,
  });

   Business.fromJson(Map<dynamic, dynamic> json) {
    formattedAddress = json['formatted_address'] != null
        ? formattedAddress = json['formatted_address']
        : null;
    formattedPhoneNumber = json['formatted_phone_number'] != null
        ? formattedPhoneNumber = json['formatted_phone_number']
        : null;
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ? new OpeningHours.fromJson(json['opening_hours'])
        : null;
    types = json['types'] != null ? types = json['types'] : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.formattedAddress != null) {
      data['formatted_address'] = this.formattedAddress;
    }
    if (this.formattedPhoneNumber != null) {
      data['formatted_phone_number'] = this.formattedPhoneNumber;
    }
    data['name'] = this.name;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours?.toJson();
    }
    if (this.types != null) {
      data['types'] = this.types;
    }
    return data;
  }
}

class OpeningHours {
  late bool openNow;
  late List<String> weekdayText;

  OpeningHours({required this.openNow, required this.weekdayText});

   OpeningHours.fromJson(Map<dynamic, dynamic> json) {
    openNow = json['open_now'];
    weekdayText = json['weekday_text'].cast<String>();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['open_now'] = this.openNow;
    data['weekday_text'] = this.weekdayText;
    return data;
  }
}