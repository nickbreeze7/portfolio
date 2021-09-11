import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class WomenCategory extends StatefulWidget {
  @override
  _WomenCategoryState createState() => _WomenCategoryState();
}

class _WomenCategoryState extends State<WomenCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: new Text("Women Fashion",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body: new GridView.count(
            padding: const EdgeInsets.all(5),

            crossAxisCount: 3,
            children: <Widget>[
              makeCategory(
                  catImage: 'images/dressc.jpg',
                  title: 'Dresses',
                  tag: 'categories'),
              makeCategory(
                  catImage: 'images/tees.jpg',
                  title: 'Tees',
                  tag: 'meat'),
              makeCategory(
                  catImage: 'images/blouse.jpg',
                  title: 'Blouse/Shirt',
                  tag: 'vegetables'),
              makeCategory(
                  catImage: 'images/hoodie.jpg',
                  title: 'Hoodies',
                  tag: 'fruits'),
              makeCategory(
                  catImage: 'images/blazer.jpg',
                  title: 'Blazers',
                  tag: 'categories'),
              makeCategory(
                  catImage: 'images/suit.jpg',
                  title: 'Bodysuits',
                  tag: 'meat'),
              makeCategory(
                  catImage: 'images/tank.jpg',
                  title: 'Tanks/Camis',
                  tag: 'vegetables'),
              makeCategory(
                  catImage: 'images/jacket.jpg',
                  title: 'Jackets',
                  tag: 'fruits'),
              makeCategory(
                  catImage: 'images/set.jpg',
                  title: 'Top & Down',
                  tag: 'fruits'),

              makeCategory(
                  catImage: 'images/leggings.jpg',
                  title: 'Leggings',
                  tag: 'categories'),
              makeCategory(
                  catImage: 'images/skirt.jpg',
                  title: 'Skirt',
                  tag: 'meat'),
              makeCategory(
                  catImage: 'images/shorts.jpg',
                  title: 'Shorts',
                  tag: 'vegetables'),
              makeCategory(
                  catImage: 'images/jeans.jpg',
                  title: 'Jeans',
                  tag: 'fruits'),
              makeCategory(
                  catImage: 'images/pant.jpg',
                  title: 'Pants',
                  tag: 'categories'),
              makeCategory(
                  catImage: 'images/pajamas.jpg',
                  title: 'Pajamas',
                  tag: 'meat'),
              makeCategory(
                  catImage: 'images/bra.jpg',
                  title: 'Bras',
                  tag: 'vegetables'),
              makeCategory(
                  catImage: 'images/pants.jpg',
                  title: 'Panties',
                  tag: 'fruits'),
              makeCategory(
                  catImage: 'images/shape.jpg',
                  title: 'Shaperwear',
                  tag: 'fruits'),

              makeCategory(
                  catImage: 'images/bikini.jpg',
                  title: 'Bikini Set',
                  tag: 'categories'),
              makeCategory(
                  catImage: 'images/cover.jpg',
                  title: 'Cover Up',
                  tag: 'meat'),
              makeCategory(
                  catImage: 'images/wedding.jpg',
                  title: 'Wedding',
                  tag: 'vegetables'),
              makeCategory(
                  catImage: 'images/prom.jpg',
                  title: 'Prom Dress',
                  tag: 'fruits'),
              makeCategory(
                  catImage: 'images/evening.jpg',
                  title: 'Evening Dress',
                  tag: 'categories'),
              makeCategory(
                  catImage: 'images/cap.jpg',
                  title: 'Caps & Hats',
                  tag: 'meat'),
              makeCategory(
                  catImage: 'images/belt.jpg',
                  title: 'Belts',
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
