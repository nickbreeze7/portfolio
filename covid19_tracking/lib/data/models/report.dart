import 'package:flutter/foundation.dart';

class Report {
  final String country;
  final String totalCases;
  final String newCases;
  final String activeCases;
  final String criticalCases;
  final String recoveredCases;
  final String totalDeaths;

  Report(
      {@required this.country,
      @required this.totalCases,
      @required this.newCases,
      @required this.activeCases,
      @required this.criticalCases,
      @required this.recoveredCases,
      @required this.totalDeaths});
}
