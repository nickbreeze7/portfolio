import 'package:bindoo/Widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatelessWidget
{
  final String message;
  const LoadingAlertDialog({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            height: 10.0,
            width: 10.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(message),
        ],
      ),
    );
  }
}