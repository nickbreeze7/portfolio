import 'package:flutter/material.dart';
import 'package:internet_radio/pages/radio_page.dart';

class FavRadiosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new RadioPage(
      isFavouriteOnly: true,
    );
  }
}
