import 'package:flutter/material.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Savings'),
      ),
      body: const Center(
        child: Text(
          'Savings',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
