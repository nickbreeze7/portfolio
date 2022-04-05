import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('MyPage'),
      ),
      body: Center(
        child: Text(
          'MyPage',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
