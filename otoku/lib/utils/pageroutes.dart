import 'package:flutter/material.dart';

class routes {
  Future pageroute(BuildContext context, Widget page) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  Future pageroutere(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  void pageback(BuildContext context) {
    return Navigator.pop(context);
  }
}
