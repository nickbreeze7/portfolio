
import 'package:bindoo/Models/slide.dart';
import 'package:flutter/material.dart';



class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage(slideList[index].imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),

        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            slideList[index].description,style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
