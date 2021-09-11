
import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'images/slide1.jpg',
    description: 'Relax and browse through over million items Specially made for you.',
  ),
  Slide(
    imageUrl: 'images/slide2.jpg',
    description: 'Using your Credit/Debit Card on the app is easy and 100% secured',
  ),
  Slide(
    imageUrl: 'images/baby.jpg',
    description: 'Item is delivered on time and to any place you might be.',
  ),
];