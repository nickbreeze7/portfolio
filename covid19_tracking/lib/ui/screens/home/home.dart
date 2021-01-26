import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../global/global.dart';
import '../all-countries/all_countries.dart';
import 'package:covid19_tracking/ui/screens/utils/Search.dart';
import 'package:flutter/services.dart';
import 'package:covid19_tracking/data/providers/reports.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('Covid-19 Tracking'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: FaIcon(FontAwesomeIcons.globe),
                text: 'GLOBAL',
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.list),
                text: 'ALL COUNTRIES',
              ),
            ],
          ),
          /* actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // showSearch(context: context, delegate: Search());
              },
            )
          ],*/
        ),
        body: TabBarView(
          children: [
            GlobalScreen(),
            AllCountriesScreen(),
          ],
        ),
      ),
    );
  }
}
