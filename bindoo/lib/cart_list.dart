

import 'package:bindoo/Config/config.dart';
import 'package:bindoo/Counters/total_amount.dart';
import 'package:bindoo/my_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'Address/adress_page.dart';
import 'Config/config.dart';
import 'Config/config.dart';
import 'Counters/cart_count.dart';


class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  double totalAmount;

  @override
  void initState() {
    super.initState();
    totalAmount=0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:StreamBuilder(
          stream: Firestore.instance.collection('products').where("pname",whereIn: BindooApp.sharedPreferences.getStringList(BindooApp.userCartList)).snapshots(),
          builder: (context, snapshot){
            return  (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData)? Center(
              child: CircleAvatar(
                  radius: 64.0,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25,),
                      Icon(Icons.remove_shopping_cart,color: Theme.of(context).primaryColor,),
                      Text("Empty Cart",style: TextStyle(color: Colors.grey,fontSize: 22),),
                    ],
                  )),
            ):snapshot.data.documents.length==0
                ?Center(
              child: CircleAvatar(
                  radius: 64.0,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25,),
                      Icon(Icons.remove_shopping_cart,color: Theme.of(context).primaryColor,),
                      Text("Empty Cart",style: TextStyle(color: Colors.grey,fontSize: 22),),
                    ],
                  )),
            ):
            new ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot products = snapshot.data.documents[index];
                  return cartItems(context, snapshot.data.documents[index]);
                }
            );
          }),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.black,
        elevation: 0.0,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5,
        child: new Container(
          height: 50,
          decoration: new BoxDecoration(color: Colors.white),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer2<TotalAmount,CartItemCounter>(builder: (context,amountProvider,cartProvider,c){
                return cartProvider.count==0? Container(): Text("Total: GHC ${amountProvider.totalAmount.toString()}");
              }),
               checkOut(),

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
         trailing: IconButton(
           onPressed: (){
             removeItemFromCart(document['pname']);
             removeItemFromYetToOder(document["pname"]);
             Navigator.push(
                 context, PageTransition(type: PageTransitionType.fade, child: MyCart()
             ));

           },
           icon: Icon(Icons.delete_forever,color: Theme.of(context).primaryColor,)
         ),
         leading: new Image.network(
           document['image1'],
           height: 120,
         ),
         title: new Text(
           document['pname'],overflow: TextOverflow.ellipsis,
           style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14, color: Colors.black),
         ),
         subtitle: new Column(
           children: <Widget>[
             new Row(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 1, 1, 4),
                   child: new Text("Large ,"),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 1, 1, 4),
                   child: new Text(
                     "Red",
                     style: TextStyle(
                         fontWeight: FontWeight.w700, color: Colors.grey),
                   ),
                 ),
                 new Padding(
                   padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                   child: new Text("Qty"),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 1, 1, 4),
                   child: new Text(
                     "1",
                     style: TextStyle(
                         fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),
                   ),
                 ),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Container(
                   alignment: Alignment.bottomCenter,
                   child: new Text("GHC "+
                     document['price'].toString(),
                     style: TextStyle(
                         fontWeight: FontWeight.w700, color: Colors.pink),
                   ),
                 ),


               ],
             ),
           ],
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

          RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("CHECKOUT"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              textColor: Colors.white,
              onPressed: (){
                Navigator.push(
                    context, PageTransition(type: PageTransitionType.fade, child: AddressPage()
                ));
              }),
        ],
      );
    }

  }
  removeItemFromCart(String productId){
    List tempList = BindooApp.sharedPreferences.getStringList(BindooApp.userCartList);
    tempList.remove(productId);

    BindooApp.firestore.collection(BindooApp.collectionUser).document(BindooApp.sharedPreferences.getString(
        BindooApp.userUID)).updateData({BindooApp.userCartList:tempList}).then((v) {
      Fluttertoast.showToast(msg: "Item removed");
      BindooApp.sharedPreferences.setStringList(BindooApp.userCartList, tempList);
      Provider.of<CartItemCounter>(context,listen: false).displayResult();
    });
  }
  removeItemFromYetToOder(String productId){
    List tempList = BindooApp.sharedPreferences.getStringList(BindooApp.userOrderList);
    tempList.remove(productId);

    BindooApp.firestore.collection(BindooApp.collectionUser).document(BindooApp.sharedPreferences.getString(
        BindooApp.userUID)).updateData({BindooApp.userOrderList:tempList}).then((v) {
      BindooApp.sharedPreferences.setStringList(BindooApp.userOrderList, tempList);
      Provider.of<CartItemCounter>(context,listen: false).displayResult();
    });
  }
  List tempList = BindooApp.sharedPreferences.getStringList(BindooApp.userCartList);

}
