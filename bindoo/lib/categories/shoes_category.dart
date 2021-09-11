import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class ShoeCategory extends StatefulWidget {
  @override
  _ShoeCategoryState createState() => _ShoeCategoryState();
}

class _ShoeCategoryState extends State<ShoeCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: new Text("Shoes For All",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/sneaker.jpg',
              title: 'Sneakers',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/wSandals.jpg',
              title: 'Sandals',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/mSandals.jpg',
              title: 'Men Sandals',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/flat.jpg',
              title: 'Flats',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/heels.jpg',
              title: 'High Heels',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/boots.jpg',
              title: 'Boots',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/cShoes.jpg',
              title: 'Casual Shoes',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/loafers.jpg',
              title: 'Loafers',
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
