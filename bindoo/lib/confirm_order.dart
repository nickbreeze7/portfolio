import 'dart:async';
import 'dart:math';


import 'package:bindoo/Counters/cart_count.dart';
import 'package:bindoo/start_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Config/CustomTextStyle.dart';
import 'Config/config.dart';
import 'home_page.dart';



class ConfirmOrder extends StatefulWidget {
  final DocumentSnapshot document;
  final String name;
  final String phone;
  final String location;
  const ConfirmOrder({Key key, this.name,this.phone,this.location,this.document}):super(key:key);
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    DateTime newDate = DateTime(now.year, now.month, now.day + 15);
    String formattedDate = DateFormat('EEE d MMM yyyy').format(newDate);
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: new Text("Confirm Order",style: TextStyle(color: Colors.white),),

      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: Firestore.instance.collection('products').where("pname",whereIn: BindooApp.sharedPreferences.getStringList(BindooApp.userCartList)).snapshots(),
                    builder: (context, snapshot){
                      return  (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData)? Center(
                        child: CircularProgressIndicator(),
                      ):snapshot.data.documents.length==0
                          ?Center(
                        child: CircularProgressIndicator(),
                      ):
                      new ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {

                            DocumentSnapshot products = snapshot.data.documents[index];
                            return cartItems(context, snapshot.data.documents[index]);
                          }
                      );
                    }),
                SizedBox(
                  width: 15,
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(color: Colors.grey.shade200)),
                      padding: EdgeInsets.only(left: 12, top: 8, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.document['receiverName'],
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(fontSize: 14),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 4, bottom: 4),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  child: Text(
                                    "HOME",
                                    style: CustomTextStyle.textFormFieldBlack
                                        .copyWith(
                                        color: Colors.white, fontSize: 9),
                                  ),
                                ),
                              )
                            ],
                          ),
                          createAddressText('First Gate, Pantang hospital rd', 16),
                          createAddressText(widget.document['receiverAddress'], 6),
                          createAddressText('Accra', 6),
                          SizedBox(
                            height: 6,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Mobile : ",
                                  style: CustomTextStyle.textFormFieldMedium
                                      .copyWith(
                                      fontSize: 12,
                                      color: Colors.grey.shade800)),
                              TextSpan(
                                  text: widget.document['receiverPhone'],
                                  style: CustomTextStyle.textFormFieldBold
                                      .copyWith(
                                      color: Colors.black, fontSize: 12)),
                            ]),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            color: Colors.grey.shade300,
                            height: 1,
                            width: double.infinity,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                                    width: 1),
                                color: Theme.of(context).primaryColor.withOpacity(0.2)),
                            margin: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                  groupValue: 1,
                                  onChanged: (isChecked) {},
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Express Delivery | Arrives on",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      formattedDate,
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                        color: Colors.pink,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                                    width: 1),
                                color: Theme.of(context).primaryColor.withOpacity(0.2)),
                            margin: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                  groupValue: 1,
                                  onChanged: (isChecked) {},
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Payment Method",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "MTN MOMO to 0550817081",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                        color: Colors.pink,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                        color: Colors.grey.shade200)),
                                padding: EdgeInsets.only(
                                    left: 12, top: 8, right: 12, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "PRICE DETAILS",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                          fontSize: 12,
                                          color: Colors.pink,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 0.5,
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      color: Colors.grey.shade400,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Total MRP",
                                    ),
                                    createPriceItem(
                                        "Item Discount", "-20%", Colors.grey),
                                    createPriceItem("Tax", "0.00", Colors.grey),
                                    createPriceItem("Order Total",
                                        'GHC 000', Colors.pink),
                                    createPriceItem("Delievery Charges", "GHC 15",
                                        Colors.teal.shade300),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 0.5,
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      color: Colors.grey.shade400,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Total",
                                          style: CustomTextStyle
                                              .textFormFieldSemiBold
                                              .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          'GHC 000',
                                          style: CustomTextStyle
                                              .textFormFieldMedium
                                              .copyWith(
                                              color: Colors.pink,
                                              fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("CONFIRM"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Theme.of(context).primaryColor)),
                    textColor: Colors.white,
                    onPressed: (){
                      addOrderDetails();
                      showThankYouBottomSheet(context);
                      Timer(
                          Duration(seconds: 2),
                              () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartUpPage())));
                    })
              ],
            ),
          ),
        ),
      ),


    );
  }
  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("images/ic_thank_you.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                            "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            style: CustomTextStyle.textFormFieldMedium.copyWith(
                                fontSize: 14, color: Colors.grey.shade800),
                          )
                        ])),
                    SizedBox(
                      height: 24,
                    ),

                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }
  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: CustomTextStyle.textFormFieldMedium
            .copyWith(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }
  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: color, fontSize: 12),
          )
        ],
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
  addOrderDetails(){
    Random random = new Random();
    int randomNumber = random.nextInt(1000000000) + 10000000;
    writeOrderDetails({
      "orderID":randomNumber,
      "orderBy": BindooApp.sharedPreferences.getString(BindooApp.userUID),
      "ProductID":BindooApp.sharedPreferences.getStringList(BindooApp.userCartList),
      "paymentMethod":"Cash on Delivery",
      "orderTime": DateTime.now().millisecondsSinceEpoch.toString(),
      BindooApp.isSuccess: true,
    });
    writeOrderDetailsAdmin({
      "orderBy": BindooApp.sharedPreferences.getString(BindooApp.userUID),
      "ProductID":BindooApp.sharedPreferences.getStringList(BindooApp.userCartList),
      "paymentMethod":"Cash on Delivery",
      "orderTime": DateTime.now().millisecondsSinceEpoch.toString(),
      BindooApp.isSuccess: true,
    }).whenComplete(() =>{
      emptyCart(),
    addItemToUserOrder(widget.document["pname"], context),
    });

  }


  Future writeOrderDetails(Map<String,dynamic>data) async{
    await BindooApp.firestore.collection(BindooApp.collectionUser)
        .document(BindooApp.sharedPreferences.getString(BindooApp.userUID))
        .collection(BindooApp.collectionOrders).document(BindooApp.sharedPreferences.getString(BindooApp.userUID)+data['orderTime'])
        .setData(data);
  }
  Future writeOrderDetailsAdmin(Map<String,dynamic>data) async{
    await BindooApp.firestore
        .collection(BindooApp.collectionOrders).document(BindooApp.sharedPreferences.getString(BindooApp.userUID)+data['orderTime'])
        .setData(data);
  }

  emptyCart() {
    BindooApp.sharedPreferences.setStringList(BindooApp.userCartList, ['garbageValue']);
    List tempList = BindooApp.sharedPreferences.getStringList(BindooApp.userCartList);
    Firestore.instance.collection('users').document(BindooApp.sharedPreferences.getString(BindooApp.userUID)).updateData({

      BindooApp.userCartList:tempList,
    }).then((value) {
      BindooApp.sharedPreferences.setStringList(BindooApp.userCartList, tempList);
      Provider.of<CartItemCounter>(context,listen: false).displayResult();

    });
  }
  addItemToUserOrder(String productId, BuildContext context) {
    List tempList = BindooApp.sharedPreferences.getStringList(BindooApp.userOrderList);
    tempList.add(productId);
    BindooApp.firestore.collection(BindooApp.collectionUser).document(BindooApp.sharedPreferences.getString(
        BindooApp.userUID)).updateData({BindooApp.userOrderList:tempList}).then((v) {

      BindooApp.sharedPreferences.setStringList(BindooApp.userOrderList, tempList);
    });
  }
}
