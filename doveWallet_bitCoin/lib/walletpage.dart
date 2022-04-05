import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  //const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: Center(
        child: Text(
          'Wallet',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
