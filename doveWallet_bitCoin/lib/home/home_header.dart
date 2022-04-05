import 'package:dovewallet_bitcoin/models/carousel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Setting up AppBar
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 190,
                    child: Swiper(
                      itemWidth: 50,
                      itemHeight: 100,
                      itemCount: carousels.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          carousels[index].image,
                          fit: BoxFit.cover,
                        );
                      },
                      pagination: new SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: new DotSwiperPaginationBuilder(
                            color: Colors.grey, activeColor: Color(0xff38547C)),
                      ),
                      control: new SwiperControl(
                        color: Color(0xff38547C),
                      ),
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
}
