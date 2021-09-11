import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class BeautyHealth extends StatefulWidget {
  @override
  _BeautyHealthState createState() => _BeautyHealthState();
}

class _BeautyHealthState extends State<BeautyHealth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: new Text("Beauty & Health",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/wig.jpg',
              title: 'Wigs',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/nail.jpg',
              title: 'Nail-Tools',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/makeUp.jpg',
              title: 'Make-Up',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/skin.jpg',
              title: 'Skin Care',
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
