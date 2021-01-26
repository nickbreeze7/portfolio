import 'package:flutter/foundation.dart';
import '../models/report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Reports with ChangeNotifier {
  List<Report> _reports = [];

  List<Report> get reports {
    return [..._reports];
  }

  Report _globalCases;

  Report get globalCases {
    return _globalCases;
  }

  Future getdata() async {
    final url = 'https://covid-193.p.rapidapi.com/statistics';
    final headers = {
      'x-rapidapi-host': 'covid-193.p.rapidapi.com',
      'x-rapidapi-key': '09639a19dbmsh5717dc52726815ep1b5209jsn3a2d12b9955c',
    };
    final response = await http.get(url, headers: headers);

    final responseData = json.decode(response.body)['response'];

    responseData.forEach((value) {
      if (value['country'] == 'All') {
        _globalCases = Report(
          country: value['country'],
          totalCases: value['cases']['total'].toString(),
          newCases: value['cases']['new'].toString(),
          activeCases: value['cases']['active'].toString(),
          criticalCases: value['cases']['critical'].toString(),
          recoveredCases: value['cases']['recovered'].toString(),
          totalDeaths: value['deaths']['total'].toString(),
        );
      } else {
        final report = Report(
          country: value['country'],
          totalCases: value['cases']['total'].toString(),
          newCases: value['cases']['new'] == null
              ? '0'
              : value['cases']['new'].toString(),
          activeCases: value['cases']['active'] == null
              ? '0'
              : value['cases']['active'].toString(),
          criticalCases: value['cases']['critical'] == null
              ? '0'
              : value['cases']['critical'].toString(),
          recoveredCases: value['cases']['recovered'] == null
              ? '0'
              : value['cases']['recovered'].toString(),
          totalDeaths: value['cases']['total'] == null
              ? '0'
              : value['deaths']['total'].toString(),
        );
        _reports.add(report);
      }
    });
    _reports.sort((a, b) => a.country.compareTo(b.country));
  }
}
