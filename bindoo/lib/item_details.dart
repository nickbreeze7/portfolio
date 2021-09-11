




import 'package:bindoo/Config/config.dart';
import 'package:bindoo/Counters/cart_count.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'Address/adress_page.dart';
import 'my_cart.dart';


class ItemDetailsPage extends StatefulWidget {


String image1;
String size1;
String size2;
String size3;
  ItemDetailsPage({this.document,this.image1,this.size1,this.size2,this.size3});
  final DocumentSnapshot document;


  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {

double _scale= 1.0;
double _previousScale= 1.0;


String color1 = "White";
String color2 = "Black";
String color3 = "Wine";
String currentColor = "White" ;
String sizePicked="";
int selectedSize;
int selectedImage = 0;
Color color;

@override
  void initState() {
    super.initState();
selectedSize=0;
  }
   setSelectedSize(int val){
     setState(() {
       selectedSize=val;
     });
   }
  @override
  Widget build(BuildContext context) {


    DateTime now = DateTime.now();
    DateTime newDate = DateTime(now.year, now.month, now.day + 15);
    String formattedDeate = DateFormat('EEE d MMM yyyy').format(newDate);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                iconTheme: IconThemeData(
                color: Colors.white,),
              backgroundColor: Colors.transparent,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: new SizedBox(
                    height: 300.0,
                    width: double.infinity,
                    child:  Carousel(
                      images: [
          
                        
                       NetworkImage(widget.image1)

                      ],
                      dotBgColor: Colors.transparent,

                      dotSize: 3,
                      autoplay: false,
                    )),
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
                        radius: 7,
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
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Divider(color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("GH₵ "+
                    widget.document['price'].toString(),
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.pink),
                  ),
                  new IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ),
                      onPressed: () {}),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("GH₵ "+
                    widget.document['oldPrice'],
                    style: TextStyle(fontSize: 20, color: Colors.grey,decoration: TextDecoration.lineThrough,),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.pink),
                      child: Text(
                        widget.document['discount'],
                        style: TextStyle(
                            
                            fontSize: 14,
                            color: Colors.white),
                      ))
                ],
              ),
              new Text(widget.document['pname'],
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 5,
              ),
              Divider(color: Colors.grey),
              new Row(
                children: <Widget>[
                  new Text(
                    "Shipping:  ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  new Text(
                    "Free Shipping From China",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Text(
                    "Estimated Delivery Time:  ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  new Text(
                    formattedDeate,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.pink),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              Row(
                      children: <Widget>[
                        SizedBox(width: 12,),
                        Text('Colors: ',style: TextStyle(color: Colors.black,fontSize: 14),),
                        Text(currentColor,style: TextStyle(color: Colors.grey,fontSize: 14),),
                      ],
                    ),
                    Container(
                            padding: EdgeInsets.all(5),
                            height: 80,
                            child: Row(
                              children: <Widget>[
                                InkWell(

                                    onTap : (){
                                      setState(() {

                                        widget.image1 = widget.document['image1'];
                                        currentColor=color1;
                                      });
                                    },
                                    child:  Image.network(widget.document['image1'],)

                                ),
                                Expanded(
                                    child: InkWell(
                                        onTap : (){
                                          setState(() {
                                            widget.image1 = widget.document['image2'];
                                            currentColor= color2;
                                          });
                                        },
                                        child: Image.network(widget.document['image2'],))

                                    ),
                                Expanded(
                                    child: InkWell(
                                        onTap : (){
                                          setState(() {
                                            widget.image1 = widget.document['image2'];
                                            currentColor = color3;
                                          });
                                        },
                                        child:  Image.network(widget.document['image2'],),

                                    )),
                              ],
                            ),
                          ),
                           new SizedBox(
                height: 5.0,
              ),

              new Card(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("  Quantity: "),
                    ),
          new Container(
            width: double.infinity,
            margin: new EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CartCounter(),



              ],
            ),

          ),
                    SizedBox(height: 15,),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(" Available Sizes ",style: TextStyle(fontSize: 18),),
              ),
              Card(

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


                      RadioListTile(
                          value: 1,
                          groupValue: selectedSize,
                          title: Text(widget.document['size1']),
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val){
                            sizePicked =widget.document["size1"];
                            setSelectedSize(val);
                          }),
                      RadioListTile(
                          value: 2,
                          groupValue: selectedSize,
                          title: Text(widget.document['size2']),
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val){
                            sizePicked =widget.document["size2"];
                            setSelectedSize(val);
                          }),
                      RadioListTile(

                          value: 3,
                          groupValue: selectedSize,
                          title: Text(widget.document['Size3']),
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val){
                            setSelectedSize(val);
                            sizePicked =widget.document["Size3"];

                          }),


                    ],
                  ),
                ),
              ),

              new Card(

                child: new Container(
                  width: double.infinity,
                  margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        "Description",
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        widget.document["description"],
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      new SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.black,
        elevation: 0.0,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5,
        child: new Container(
          height: 50,
          decoration: new BoxDecoration(color: Colors.white),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                margin: const EdgeInsets.only(bottom: 5.0),
                height: 50,
                padding: const EdgeInsets.all(5),
                child:
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("+ CART"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              textColor: Colors.white,
              onPressed: (){
                checkItemInCart(widget.document['pname'], context);
                yetToPurchase(widget.document['pname'], context);
              }),
        ],
      ),
              ),


              
            ],
          ),
        ),
      ),
    );
  }

  void checkItemInCart(String productId,BuildContext context) {
    BindooApp.sharedPreferences.getStringList(BindooApp.userCartList).contains(productId)
        ? Fluttertoast.showToast(msg: "Item already in cart")
        : addItemToCart(productId,context);
  }
  
}

addItemToCart(String productId, BuildContext context) {
  List tempList = BindooApp.sharedPreferences.getStringList(BindooApp.userCartList);
  tempList.add(productId);
  BindooApp.firestore.collection(BindooApp.collectionUser).document(BindooApp.sharedPreferences.getString(
      BindooApp.userUID)).updateData({BindooApp.userCartList:tempList}).then((v) {
    Fluttertoast.showToast(msg: "Item added");
    BindooApp.sharedPreferences.setStringList(BindooApp.userCartList, tempList);
    Provider.of<CartItemCounter>(context,listen: false).displayResult();
  });

}
yetToPurchase(String productId, BuildContext context) {
  List tempList = BindooApp.sharedPreferences.getStringList(BindooApp.userOrderList);
  tempList.add(productId);
  BindooApp.firestore.collection(BindooApp.collectionUser).document(BindooApp.sharedPreferences.getString(
      BindooApp.userUID)).updateData({BindooApp.userOrderList:tempList}).then((v) {
    BindooApp.sharedPreferences.setStringList(BindooApp.userOrderList, tempList);
    Provider.of<CartItemCounter>(context,listen: false).displayResult();
  });
}
class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}
class _CartCounterState extends State<CartCounter> {
  int numOfItems =1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlinedButton(iconData: Icons.remove,press: (){
         if(numOfItems>1){
           setState(() {
             numOfItems--;
           });
         }
        }),
        SizedBox(width: 5,),
        new Text(numOfItems.toString().padLeft(2,"0"), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400,color: Colors.black),),
        SizedBox(width: 5,),
        buildOutlinedButton(iconData: Icons.add,press: (){
          setState(() {
            numOfItems++;
          });
        }),
      ],
    );
  }
}

SizedBox buildOutlinedButton({IconData iconData, Function press}){
  return SizedBox(
    width: 40,
    height: 32,
    child: OutlineButton(
      padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)
        ),
        onPressed: press,
    child: Icon(iconData),),
  );
}

