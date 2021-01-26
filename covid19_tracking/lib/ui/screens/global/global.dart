import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/status_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../data/providers/reports.dart';

class GlobalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Reports>(
      builder: (context, model, child) {
        // TODO: implement build
        return GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: [
            StatusCard(
              icon: 'assets/images/icons/total.png',
              status: NumberFormat.compact().format(
                double.parse(model.globalCases.totalCases),
              ),
              label: 'Total',
              color: Colors.pink,
            ),
            StatusCard(
              icon: 'assets/images/icons/new.png',
              status: NumberFormat.compact().format(
                double.parse(model.globalCases.newCases),
              ),
              label: 'New',
              color: Colors.blue,
            ),
            StatusCard(
              icon: 'assets/images/icons/active.png',
              status: NumberFormat.compact().format(
                double.parse(model.globalCases.activeCases),
              ),
              label: 'Active',
              color: Colors.teal,
            ),
            StatusCard(
              icon: 'assets/images/icons/critical.png',
              status: NumberFormat.compact().format(
                double.parse(model.globalCases.criticalCases),
              ),
              label: 'Critical',
              color: Colors.orange,
            ),
            StatusCard(
              icon: 'assets/images/icons/recovered.png',
              status: NumberFormat.compact().format(
                double.parse(model.globalCases.recoveredCases),
              ),
              label: 'Recovered',
              color: Colors.green,
            ),
            StatusCard(
              icon: 'assets/images/icons/death.png',
              status: NumberFormat.compact().format(
                double.parse(model.globalCases.totalDeaths),
              ),
              label: 'Deaths',
              color: Colors.red,
            ),
          ],
        );
      },
    );
  }
}
