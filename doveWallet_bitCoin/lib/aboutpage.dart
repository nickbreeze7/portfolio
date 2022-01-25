import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade200,
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Center(
        child: Text(
          'About',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
