import 'package:covid19_tracking/ui/constants/constants.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatefulWidget {
  final String icon;
  final String status;
  final String label;
  final Color color;

  StatusCard({this.icon, this.status, this.label, this.color});

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> with TickerProviderStateMixin {
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
    return ScaleTransition(
      scale: _animation,
      child: Card(
        shape: kCardShape,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              widget.icon,
              height: 60,
            ),
            Text(
              widget.status,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: widget.color,
              ),
            ),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
