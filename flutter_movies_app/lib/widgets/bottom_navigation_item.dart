import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/constants.dart';

class BottomNavigationItem extends StatelessWidget {
  final Icon icon;
  final double iconSize;
  final Function? onPressed;
  Color? color;


  BottomNavigationItem({
    required this.icon,
    required this.iconSize,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      color: color ?? kInactiveButtonColor,
      onPressed: () => onPressed!(),
      icon: icon);
  }
}
