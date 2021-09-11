import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bindoo/Widget/searchBox.dart';
import 'package:bindoo/category_display.dart';
import 'package:bindoo/category_page.dart';
import 'package:bindoo/item_details.dart';
import 'package:bindoo/product_details.dart';
import 'package:bindoo/search_page.dart';
import 'package:bindoo/Counters/cart_count.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'Config/CustomShapeClipper.dart';
import 'Config/config.dart';
import 'my_cart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

TextEditingController searchName = new TextEditingController();
Stream<QuerySnapshot> firestore = Firestore.instance.collection('products').snapshots();
class _HomePageState extends State<HomePage> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Image(image: AssetImage('images/log.png',),height: 35,),
                backgroundColor: Colors.transparent,
                expandedHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  background: ClipPath(
                    clipper: CustomShapeClipper(),
                    child: Container(
                      height: 80,
                      color: Theme.of(context).primaryColor,

                    ),
                  ),
                ),
                actions: <Widget>[

                  new Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: new IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) =>MyCart()));}),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7, top: 7),
                        child: new CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: 8,
                          child: Consumer<CartItemCounter>(
                            builder: (context, counter,_){
                             return Text((BindooApp.sharedPreferences.getStringList(BindooApp.userCartList).length-1).toString(),
                               style: TextStyle(color: Colors.white,fontSize: 12),
                                            );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),),
                    child: TextField(
                        readOnly: true,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>SearchPage()));
                      },
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(
                      height: 120.0,
                      width: double.infinity,
                      child: Carousel(
                        images: [
                          NetworkImage('https://ae01.alicdn.com/kf/H6fdd8d395edb4f28a66ac5f7797e4ad9U.png_.webp'),
                          NetworkImage('https://ae01.alicdn.com/kf/Hecaf5ceb6abe4daeb627fb9be1c9c9a4e.png_.webp'),
                          NetworkImage('https://ae01.alicdn.com/kf/HTB19s9VaPvuK1Rjy0Faq6x2aVXaN.jpg_.webp')
                        ],
                        dotBgColor: Colors.transparent,
                        animationDuration: Duration(milliseconds: 800),
                        dotSize: 3,
                        borderRadius: true,
                        animationCurve: Curves.bounceOut,
                      )),
                ),
                Card(
                  child: Container(
                      height: 100,
                      child: new GridView.count(
                        padding: const EdgeInsets.all(5),
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        children: <Widget>[
                          makeCategory(
                              catImage: 'images/allCat.png',
                              title: 'New User',
                              tag: 'categories',
                              onTap: (){Navigator.push(
                                  context, PageTransition(type: PageTransitionType.fade, child: CategoryDisplay(title: 'New User')
                              ));}),
                          makeCategory(
                              catImage: 'images/flash.png',
                              title: 'Flash Deals',
                              tag: 'meat',
                              onTap: (){Navigator.push(
                                  context, PageTransition(type: PageTransitionType.fade, child: CategoryDisplay(title: 'Flash Deals')
                              ));}),
                          makeCategory(
                              catImage: 'images/hot.png',
                              title: 'Hot Deals',
                              tag: 'vegetables',
                              onTap: (){Navigator.push(
                                  context, PageTransition(type: PageTransitionType.fade, child: CategoryDisplay(title:'Hot Deals')
                              ));}),
                          makeCategory(
                              catImage: 'images/buyers.png',
                              title: 'Top Sales',
                              tag: 'fruits',
                              onTap: (){Navigator.push(
                                  context, PageTransition(type: PageTransitionType.fade, child: CategoryDisplay(title: 'Buyers Pick')
                              ));}),

                        ],
                      )),
                ),
                 Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                                  image: new AssetImage("images/red1.png"),
                                  fit: BoxFit.cover),
                              borderRadius: new BorderRadius.only(
                                topRight: new Radius.circular(10),
                                topLeft: new Radius.circular(10),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Text(
                                  "New User Gifts",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          padding: EdgeInsets.only(left: 5),
                          child: StreamBuilder(
                            stream: Firestore.instance.collection('products').where('subCat',isEqualTo:'New User' ).snapshots(),
                              builder: (context, snapshot){
                                if(snapshot.data == null) return CircularProgressIndicator();
                              return new ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                   DocumentSnapshot products = snapshot.data.documents[index];
                                   return hotDeals(context, snapshot.data.documents[index]);
                                  }
                              );
                              })
                        ),

                      ],
                    ),
                  ),

                GestureDetector(
                  onTap: (){Navigator.push(
                      context, PageTransition(type: PageTransitionType.fade, child: CategoryDisplay(title: 'New User')
                  ));},
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 100,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: new AssetImage("images/ban.jpg"),
                              fit: BoxFit.cover),
                          borderRadius: new BorderRadius.only(
                            topRight: new Radius.circular(5),
                            topLeft: new Radius.circular(5),
                            bottomLeft: new Radius.circular(5),
                            bottomRight: new Radius.circular(5),
                          )),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.whatshot, color: Colors.orange),
                      Text(
                        "Hot Deals",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Hot deals up to 70% OFF Today",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Container(
                      height: 100,
                      padding: EdgeInsets.only(left: 5),
                      child: StreamBuilder(
                          stream: Firestore.instance.collection('products').where("subCat", isEqualTo: "Hot Deals").snapshots(),
                          builder: (context, snapshot){
                            if(snapshot.data == null) return CircularProgressIndicator();
                            return new ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot products = snapshot.data.documents[index];
                                  return hotDeals(context, snapshot.data.documents[index]);
                                }
                            );
                          })
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                                image: new AssetImage("images/blue.png"),
                                fit: BoxFit.cover),
                            borderRadius: new BorderRadius.only(
                              topRight: new Radius.circular(10),
                              topLeft: new Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Text(
                                "2021 New Products",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                            height: 130,
                            padding: EdgeInsets.only(left: 5),
                            child: StreamBuilder(
                                stream: Firestore.instance.collection('products').where("subCat", isEqualTo: "New").snapshots(),
                                builder: (context, snapshot){
                                  if(snapshot.data == null) return CircularProgressIndicator();
                                  return new ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot products = snapshot.data.documents[index];
                                        return newDeals(context, snapshot.data.documents[index]);
                                      }
                                  );
                                })
                        ),
                      ),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){Navigator.push(
                      context, PageTransition(type: PageTransitionType.fade, child: CategoryDisplay(title: 'Beauty & Health')
                  ));},
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 100,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: new AssetImage("images/b.jpg"),
                              fit: BoxFit.cover),
                          borderRadius: new BorderRadius.only(
                            topRight: new Radius.circular(5),
                            topLeft: new Radius.circular(5),
                            bottomLeft: new Radius.circular(5),
                            bottomRight: new Radius.circular(5),
                          )),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    "Just For You!!!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                StreamBuilder(
                  stream: Firestore.instance.collection("products").snapshots(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.documents[index];
                        return ProductsUI(context, snapshot.data.documents[index]);;
                      },
                    );
                  },
                ),
              ],

            ),
          ),),

    );
  }
  Widget makeCategory({catImage, title, tag, Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,

            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(catImage), fit: BoxFit.cover),
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
  Widget hotDeals(BuildContext context, DocumentSnapshot document) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context, PageTransition(type: PageTransitionType.fade, child: ItemDetailsPage(
            document: document,image1:document["image1"],size1:document["size1"],size2:document["size2"],size3:document["Size3"])
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 90,
                    width: 90,
                    child: Image.network(
                      document['image1'],
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    left: 10,
                    top: 65,
                    right: 10,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.pink),
                            child: Text("GH₵ "+
                                document['price'].toString(),
                              style:
                              TextStyle(fontSize: 12, color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget ProductsUI(BuildContext context, DocumentSnapshot document
      ) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context, PageTransition(type: PageTransitionType.fade, child: ItemDetailsPage(
            document: document,image1:document["image1"],size1:document["size1"],size2:document["size2"],size3:document["Size3"])
        ));
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(

          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 140,
                    width: 160,
                    child: Image.network(
                      document['image1'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    width: 140,
                    height: 30,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.transparent, Colors.transparent])),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 115,
                    right: 10,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: new Row(
                            children: <Widget>[

                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.pink),
                            child: Text(
                              document['discount'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(

              document['pname'],overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Text(
                  'GHC'+ document['price'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.pink),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'GHC'+ document['price'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
  Widget newDeals(BuildContext context, DocumentSnapshot document) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context, PageTransition(type: PageTransitionType.fade, child: ItemDetailsPage(
            document: document,image1:document["image1"],size1:document["size1"],size2:document["size2"],size3:document["Size3"])
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Column(
          children: <Widget>[

            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 90,
                    width: 90,
                    child: Image.network(
                      document['image1'],
                      fit: BoxFit.cover,
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).accentColor),
                child: Text("GH₵ "+
                    document['price'].toString(),
                  style:
                  TextStyle(fontSize: 12, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
