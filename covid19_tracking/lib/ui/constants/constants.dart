import 'package:flutter/material.dart';

final kTheme = ThemeData(
  primaryColor: Color(0XFF0E0A25),
  accentColor: Colors.white,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0XFF0E0A25),
  fontFamily: 'ABeeZee',
  cardColor: Color(0XFF14193A),
);

final kCardShape = UnderlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);

final kBottomSheetShape = UnderlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);
