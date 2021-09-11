import 'package:bindoo/Orders/OrderDetailsPage.dart';
import 'package:bindoo/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'Address/add_address.dart';
import 'Config/config.dart';
int counter=0;
class MyOrders extends StatefulWidget {

  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;

  MyOrders({Key key,this.itemCount, this.data, this.orderID}): super(key:key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: BindooApp.firestore.collection(BindooApp.collectionUser)
              .document(BindooApp.sharedPreferences.getString(BindooApp.userUID))
              .collection(BindooApp.collectionOrders).snapshots(),
          builder: (context, snapshot){
            return  (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData)? Center(
              child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Icon(Icons.library_books,color: Theme.of(context).primaryColor,),
                      Text("No Orders",style: TextStyle(color: Colors.grey,fontSize: 22),),
                    ],
                  )),
            ):snapshot.data.documents.length==0
                ?Center(
              child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Icon(Icons.library_books,color: Theme.of(context).primaryColor,),
                      Text("No Orders",style: TextStyle(color: Colors.grey,fontSize: 22),),
                    ],
                  )),
            ):
            new ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot products = snapshot.data.documents[index];
                  return orderItems(context, snapshot.data.documents[index]);
                }
            );
          }),
    );
  }
  Widget orderItems(BuildContext context, DocumentSnapshot document){
    return GestureDetector(
      onTap: (){
        if(counter==0){
          counter =counter+1;

        }
      },
      child: new Card(
        elevation: 8.0,

        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Order ID:",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
                  Text(document["orderTime"],style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),)
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Order ID:"),
                  Text(document["orderTime"])
                ],
              ),

              StreamBuilder<QuerySnapshot>(
                  stream: BindooApp.firestore.collection("products").where("pname",whereIn: BindooApp.sharedPreferences.getStringList(BindooApp.userOrderList)).snapshots(),
                  builder: (context, snapshot){
                    return  (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData)?
                    Center(child: CircularProgressIndicator()):new ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot products = snapshot.data.documents[index];
                          return cartItems(context, snapshot.data.documents[index]);
                        }
                    );
                  }
              ),

            ],
          ),
        ),

      ),
    );
  }
  Widget cartItems(BuildContext context, DocumentSnapshot document){
    return GestureDetector(
      child: new Card(
        elevation: 8.0,
        child: ListTile(

          leading: new Image.network(
            document["image1"],
            height: 60,
          ),
          title: new Text(
            document["pname"],
            style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14, color: Colors.black),
          ),

        ),
      ),
    );
  }
  Widget checkOut(){
    if(BindooApp.sharedPreferences.getStringList(BindooApp.userCartList).length== 1){
      return Container();
    }else{ return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
              children:<Widget>[
                Text(
                  "Total :",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(width:20),
                Text("GHS "
                  ,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ]
          ),
          RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("CHECKOUT"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              textColor: Colors.white,
              onPressed: (){

              }),
        ],
      );
    }

  }
}
