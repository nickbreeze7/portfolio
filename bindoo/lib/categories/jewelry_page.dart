import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class JewelryPage extends StatefulWidget {
  @override
  _JewelryPageState createState() => _JewelryPageState();
}

class _JewelryPageState extends State<JewelryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: new Text("Jewelry & Watches",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body:new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/necklace.jpg',
              title: 'Necklace',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/ring.jpg',
              title: 'Rings',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/earring.jpg',
              title: 'Earrings',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/bracelet.jpg',
              title: 'Bracelets',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/watches.jpg',
              title: 'Watches',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/body.jpg',
              title: 'Body Jewelry',
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
