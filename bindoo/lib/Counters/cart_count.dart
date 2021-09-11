import 'package:bindoo/Config/config.dart';
import 'package:flutter/foundation.dart';


class CartItemCounter extends ChangeNotifier{
  int _counter = BindooApp.sharedPreferences.getStringList(BindooApp.userCartList).length-1;
  int get count=> _counter;

  Future<void>displayResult() async{
    int _counter = BindooApp.sharedPreferences.getStringList(BindooApp.userCartList).length-1;
    await Future.delayed(const Duration(milliseconds: 100),(){
      notifyListeners();
    });
  }
}