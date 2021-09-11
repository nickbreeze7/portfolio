import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize{
  @override
Size get preferredSize=>Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: ()=>Navigator.pop(context),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14)
              ),
              child: Row(
                children: <Widget>[
                  Text("4.5"),
                  Icon(Icons.star,color: Colors.yellow,size: 18,)
                ],
              ),
            )
          ],
        ),));
  }

}