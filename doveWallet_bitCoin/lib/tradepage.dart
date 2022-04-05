import 'package:flutter/material.dart';

class TradePage extends StatelessWidget {
  const TradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Trade'),
      ),
      body: const Center(
        child: Text(
          'Trade',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}