import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../category_display_items.dart';


class BagCategory extends StatefulWidget {
  @override
  _BagCategoryState createState() => _BagCategoryState();
}

class _BagCategoryState extends State<BagCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: new Text("Bags",style: TextStyle(color: Theme.of(context).primaryColor),),),
      body: new GridView.count(
        padding: const EdgeInsets.all(5),

        crossAxisCount: 3,
        children: <Widget>[
          makeCategory(
              catImage: 'images/tote.jpg',
              title: 'Totes',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/handBag.jpg',
              title: 'Hand Bags',
              tag: 'meat'),

          makeCategory(
              catImage: 'images/backpack.jpg',
              title: 'BackPacks',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/cBody.jpg',
              title: 'Cross Body',
              tag: 'vegetables'),
          makeCategory(
              catImage: 'images/tBag.jpg',
              title: 'Travel Bag',
              tag: 'categories'),
          makeCategory(
              catImage: 'images/bCase.jpg',
              title: 'Brief Case',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/wallet.jpg',
              title: 'Wallet',
              tag: 'fruits'),
          makeCategory(
              catImage: 'images/purse.jpg',
              title: 'Women Purse',
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
