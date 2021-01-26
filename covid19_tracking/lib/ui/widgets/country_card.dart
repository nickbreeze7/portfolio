import 'package:flutter/material.dart';
import 'package:covid19_tracking/ui/widgets/details.dart';
import 'package:covid19_tracking/ui/constants/constants.dart';
import 'package:provider/provider.dart';
import '../../data/providers/reports.dart';
import 'package:intl/intl.dart';

class CountryCard extends StatefulWidget {
  final int index;

  CountryCard({this.index});

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(microseconds: 900),
      vsync: this,
    );

    _animation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: _controller,
    );
    if (_animation.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Reports>(
      builder: (context, model, child) {
        return ScaleTransition(
          scale: _animation,
          child: Card(
            shape: kCardShape,
            child: ListTile(
              onTap: () => buildBottomSheet(context),
              shape: kCardShape,
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/country_flags/${model.reports[widget.index].country}.png'),
                radius: 25,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  model.reports[widget.index].country,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:${NumberFormat.compact().format(
                      double.parse(model.reports[widget.index].totalCases),
                    )}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    'Active:${NumberFormat.compact().format(
                      double.parse(model.reports[widget.index].activeCases),
                    )}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).cardColor,
      shape: kBottomSheetShape,
      context: context,
      builder: (context) {
        return Consumer<Reports>(
          builder: (context, model, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    model.reports[widget.index].country,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Details(
                  label: 'Total',
                  status: NumberFormat.compact().format(
                    double.parse(model.reports[widget.index].totalCases),
                  ),
                  color: Colors.pink,
                ),
                Details(
                  label: 'New',
                  status: NumberFormat.compact().format(
                    double.parse(model.reports[widget.index].newCases),
                  ),
                  color: Colors.blue,
                ),
                Details(
                  label: 'Active',
                  status: NumberFormat.compact().format(
                    double.parse(model.reports[widget.index].activeCases),
                  ),
                  color: Colors.green,
                ),
                Details(
                  label: 'Critical',
                  status: NumberFormat.compact().format(
                    double.parse(model.reports[widget.index].criticalCases),
                  ),
                  color: Colors.orange,
                ),
                Details(
                  label: 'Recovered',
                  status: NumberFormat.compact().format(
                    double.parse(model.reports[widget.index].recoveredCases),
                  ),
                  color: Colors.green,
                ),
                Details(
                  label: 'Deaths',
                  status: NumberFormat.compact().format(
                    double.parse(model.reports[widget.index].totalDeaths),
                  ),
                  color: Colors.red,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
