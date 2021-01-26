import 'package:covid19_tracking/ui/widgets/country_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/reports.dart';

class AllCountriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reports = Provider.of<Reports>(context, listen: false).reports;

    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return CountryCard(index: index);
      },
    );
  }
}
