import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../category_display_items.dart';



class BabyCategory extends StatefulWidget {
  @override
  _BabyCategoryState createState() => _BabyCategoryState();
}

class _BabyCategoryState extends State<BabyCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: new Text("Kids, Babies & Toys",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/bItems.jpg',
              title: 'Baby Items',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/bShoes.jpg',
              title: 'Baby Shoes',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/bToys.jpg',
              title: 'Toys',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/maternity.jpg',
              title: 'Maternity Wear',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/bClothing.jpg',
              title: 'Baby Clothing',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/bHat.jpg',
              title: 'Baby Hats',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/bBibs.jpg',
              title: 'Baby Bibs',
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
                  color:  Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
              )),
        ],
      ),
    );
  }
}
