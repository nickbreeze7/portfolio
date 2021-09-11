import 'package:bindoo/Address/add_address.dart';
import 'package:bindoo/Config/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


import '../confirm_order.dart';



class AddressPage extends StatefulWidget {
  final double totalAmount;
  final String productName;
  final String productImage;
  final String productPrice;
  const AddressPage({Key key, this.totalAmount,this.productName,this.productImage,this.productPrice}): super(key:key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: new Text("Address",style: TextStyle(color: Colors.white),),

      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: BindooApp.firestore.collection(BindooApp.collectionUser)
              .document(BindooApp.sharedPreferences.getString(BindooApp.userUID))
              .collection(BindooApp.subCollectionAddress).snapshots(),
          builder: (context, snapshot){
            if(snapshot.data == null) return CircularProgressIndicator();
            return new ListView.builder(
              shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return addressCard(context, snapshot.data.documents[index]);
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


              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Add New Address"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  textColor: Colors.white,
                  onPressed: (){
                    Navigator.push(

                        context, PageTransition(type: PageTransitionType.fade, child: AddAddressPage()
                    ));

                  })
            ],
          ),
        ),
      ),
    );
  }
  noAddressCard(){
    
  }
Widget addressCard(BuildContext context, DocumentSnapshot document){
  return  InkWell(
    child: Card(
      
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(
                color: Colors.tealAccent.withOpacity(0.4),
                width: 1),
            color: Colors.tealAccent.withOpacity(0.2)),
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Receiver's Name: ",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      ),
                ),
                Text(
                  document['receiverName'],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),

              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Receiver's Name: ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  document['receiverPhone'],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),

              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Receiver's Address: ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Expanded(child:  Text(
                  document['receiverAddress'],overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),)


              ],
            ),
            RaisedButton(
                color: Colors.white,
                child: Text("Use this address"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                textColor: Colors.pink,
                onPressed: (){
                  Navigator.push(

                      context, PageTransition(type: PageTransitionType.fade, child: ConfirmOrder(document:document)
                  ));

                })
          ],
        ),
      ),
    ),
  );
}
}



