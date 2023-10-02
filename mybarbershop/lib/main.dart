import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'login_page.dart';


var logger = Logger(
  printer: PrettyPrinter(),
);


void main() => runApp(MyApp());

/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}*/



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(child: LoginPage()),
    );
  }
}
