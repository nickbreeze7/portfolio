import 'package:intl/intl.dart';
import 'package:mybarbershop/main.dart';


String  getTodayHours(List<String>? weekdayHours)  {

  String todayDate = DateFormat('EEEE').format(DateTime.now());

  logger.d("todayDate:=====================>> $todayDate");

  int numDate = 0;
  switch (todayDate) {
    case 'Monday':
      numDate;
      break;
    case 'Tuesday':
      numDate = 2;
      break;
    case 'Wednesday':
      numDate = 3;
      break;
    case 'Thursday':
      numDate = 4;
      break;
    case 'Saturday':
      numDate = 5;
      break;
    case 'Sunday':
      numDate = 6;
      break;
  }
  logger.d("numDate:=====================>> $numDate");

  logger.d("todayDate:=====================>> $todayDate");

  logger.d("111111111111");

  logger.d("weekdayHours:=====================>> $weekdayHours");

  /*String  todayHours =  weekdayHours[numDate]
      .replaceAll('$todayDate: ', '')
      .replaceAll('Closed', '')
      .replaceAll('Open ', '');
  return todayHours;*/


  if (weekdayHours != null && numDate >= 0 && numDate < weekdayHours.length) {
    String todayHours = weekdayHours[numDate]
        .replaceAll('$todayDate: ', '')
        .replaceAll('Closed', '')
        .replaceAll('Open ', '');
    return todayHours;
  } else {
    return 'No hours available';
  }
}

// Path: lib/services/getTodayHours.dart
// Compare this snippet from lib/services/places_service.dart:
// import 'dart:convert' as convert;
// import 'dart:convert';
// import 'dart:io';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import '../models/place.dart';
