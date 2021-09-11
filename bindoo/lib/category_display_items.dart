import 'package:bindoo/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'item_details.dart';

class CategoryDisplayItems extends StatefulWidget {
  final String title;
  CategoryDisplayItems({
    this.title
  });
  @override
  _CategoryDisplayItemsState createState() => _CategoryDisplayItemsState();
}

class _CategoryDisplayItemsState extends State<CategoryDisplayItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,
              color: Colors.white,),
            onPressed: (){Navigator.push(
                context, PageTransition(type: PageTransitionType.fade, child: SearchPage()));
            },
          ),
        ],
        title: new Text(widget.title,style: TextStyle(color: Colors.white),),),

      body:  Padding(
        padding: const EdgeInsets.only(top: 15),
        child: StreamBuilder(
          stream: Firestore.instance.collection("products").where("category",isEqualTo: widget.title).snapshots(),
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
      ),
    );
  }
  Widget ProductsUI(BuildContext context, DocumentSnapshot document
      ) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetailsPage(
                  document: document,

                )));
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
}
