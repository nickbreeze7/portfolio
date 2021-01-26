import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracking/ui/screens/home/home.dart';
import 'package:covid19_tracking/ui/constants/constants.dart';
import 'package:provider/provider.dart';
import 'data/providers/reports.dart';
import 'ui/screens/home/home.dart';
import 'package:covid19_tracking/ui/screens/splash/splash.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final model = Reports();

    return ChangeNotifierProvider(
      create: (context) => model,
      builder: (context, child) {
        return MaterialApp(
          theme: kTheme,
          home: FutureBuilder(
            future: model.getdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return SplashScreen();
                } else {
                  return HomeScreen();
                }
              }
              return HomeScreen();
            },
          ),
        );
      },
    );
  }
}
