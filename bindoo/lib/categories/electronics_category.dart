import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class ElectronicsPage extends StatefulWidget {
  @override
  _ElectronicsPageState createState() => _ElectronicsPageState();
}

class _ElectronicsPageState extends State<ElectronicsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: new Text("Consumer Electronics",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/earPhone.jpg',
              title: 'EarPhones',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/mp3.jpg',
              title: 'Bluetooth',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/mp3Player.png',
              title: 'MP3 Players',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/mic.jpg',
              title: 'Microphones',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/smart.jpg',
              title: 'Smart Watches',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/game.jpg',
              title: 'Game Pads',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/memory.jpg',
              title: 'Memory Cards',
              tag: 'fruits'),

        ],
      ),
    );
  }
  Widget makeCategory({catImage, title, tag}) {

    return GestureDetector(
      onTap: (){Navigator.push(
          context, PageTransition(type: PageTransitionType.bottomToTop, child: CategoryDisplayItems(title: title)));},
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,

            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(catImage),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
              )),
        ],
      ),
    );
  }
}
