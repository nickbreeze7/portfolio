import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class HomeDecorPage extends StatefulWidget {
  @override
  _HomeDecorPageState createState() => _HomeDecorPageState();
}

class _HomeDecorPageState extends State<HomeDecorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: new Text("Home Decoration",style: TextStyle(color: Theme.of(context).primaryColor),),),

      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/curtains.jpg',
              title: 'Curtains',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/bedSet.jpg',
              title: 'Bedding Sets',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/cushion.jpg',
              title: 'Cushion',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/sofa.jpg',
              title: 'Sofa Covers',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/carpet.jpg',
              title: 'Carpet',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/paint.jpg',
              title: 'Painting',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/sticker.jpg',
              title: 'Wall Stickers',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/wallClock.jpg',
              title: 'Wall Clocks',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/laundry.jpg',
              title: 'Laundry Bag',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/laundry.jpg',
              title: 'Umbrellas',
              tag: 'vegetables'),

          makeCategory(
              catImage: 'images/flowerPot.jpg',
              title: 'Flower Pots',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/water.jpg',
              title: 'Watering Kits',
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
                  color:Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
              )),
        ],
      ),
    );
  }
}
