import 'package:flutter/material.dart';
import 'package:flutter_movies_app/widgets/bottom_navigation_item.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_movies_app/utils/constants.dart';

class BottomNavigation extends StatelessWidget {
  final List<BottomNavigationItem>  children;
  final int index;
  final Color activeColor;


  BottomNavigation({
    required this.children,
    required this.index,
    required this.activeColor
  }){
    children[index].color = activeColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kAppBarColor,
        boxShadow: kBoxShadow,
      ),
      height: 11.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}
