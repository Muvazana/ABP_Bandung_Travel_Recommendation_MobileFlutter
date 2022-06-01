import 'package:flutter/material.dart';

class LoadingCustom {
  static BuildContext? _context;

  static set setContext(BuildContext context) => _context = context;

  static show() {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 7),
            child: Text("Loading..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: _context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static dismiss() => Navigator.pop(_context!);
}
