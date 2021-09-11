import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class MenCategory extends StatefulWidget {
  @override
  _MenCategoryState createState() => _MenCategoryState();
}

class _MenCategoryState extends State<MenCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: new Text("Men Fashion",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/tshirt.jpg',
              title: 'T-Shirts',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/mshirt.jpg',
              title: 'Shirts',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/mhoodies.jpg',
              title: 'Hoodies',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/mshorts.jpg',
              title: 'Shorts',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/mset.jpg',
              title: 'Men`s Set',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/mjacket.jpg',
              title: 'Jackets',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/casual.jpg',
              title: 'Casual Pants',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/cargo.jpg',
              title: 'Cargo Pants',
              tag: 'meat'),
          makeCategory(
              catImage: 'images/mJeans.jpg',
              title: 'Jeans',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/mSuit.jpg',
              title: 'Suits & Blazers',
              tag: 'vegetables'),

          makeCategory(
              catImage: 'images/boxer.jpg',
              title: 'Boxers',
              tag: 'fruits'),

          makeCategory(
              catImage: 'images/beanie.jpg',
              title: 'Beanies',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/gloves.jpg',
              title: 'Gloves',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/mBelt.jpg',
              title: 'Belts',
              tag: 'meat'),
          makeCategory(
              catImage: 'images/bCap.jpg',
              title: 'Baseball Caps',
              tag: 'vegetables'),

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
