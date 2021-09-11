import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class MobileAccessories extends StatefulWidget {
  @override
  _MobileAccessoriesState createState() => _MobileAccessoriesState();
}

class _MobileAccessoriesState extends State<MobileAccessories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: new AppBar(
       automaticallyImplyLeading: false,
       backgroundColor: Colors.white,
       title: new Text("Phone Accessories",style: TextStyle(color: Theme.of(context).primaryColor),),),

      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/cases.jpg',
              title: 'Phone Cases',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/cable.jpg',
              title: 'Cables',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/charger.jpg',
              title: 'Chargers',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/pBank.jpg',
              title: 'Power Banks',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/holder.jpg',
              title: 'Holders',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/protector.jpg',
              title: 'Protectors',
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
