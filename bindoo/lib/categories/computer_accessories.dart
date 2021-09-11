import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../category_display.dart';
import '../category_display_items.dart';



class ComputerAccessories extends StatefulWidget {
  @override
  _ComputerAccessoriesState createState() => _ComputerAccessoriesState();
}

class _ComputerAccessoriesState extends State<ComputerAccessories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: new Text("Computer Accessories",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/lpCase.jpg',
              title: 'LapTop Bags',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/hdCase.jpg',
              title: 'HDD Case',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/stand.jpg',
              title: 'Accessories',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/mice.jpg',
              title: 'Mice',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/keyboard.jpg',
              title: 'Keyboard',
              tag: 'categories'),


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
