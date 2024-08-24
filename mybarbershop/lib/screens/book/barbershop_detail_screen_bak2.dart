import 'package:flutter/material.dart';

void main() => runApp(BarbershopDetailScreenBak2());

class BarbershopDetailScreenBak2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5, // Total number of tabs
        child: Scaffold(
          // Use a NestedScrollView to coordinate the scroll view with the app bar
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  // This is the height of the expanded app bar, you can change it as needed
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('Barbershop'),
                    background: Image.asset(
                      'assets/barbershop.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.home), text: 'Home'),
                      Tab(icon: Icon(Icons.style), text: 'Services'),
                      Tab(icon: Icon(Icons.star), text: 'Reviews'),
                      Tab(icon: Icon(Icons.photo_album), text: 'Gallery'),
                      Tab(icon: Icon(Icons.person), text: 'Stylists'),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                HomeScreen(),
                ServicesScreen(),
                ReviewsScreen(),
                GalleryScreen(),
                StylistsScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home Content'));
  }
}

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Services Content'));
  }
}

class ReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Reviews Content'));
  }
}

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Gallery Content'));
  }
}

class StylistsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Stylists Content'));
  }
}
