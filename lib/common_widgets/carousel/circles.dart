import 'package:flutter/material.dart';

List<Widget> circles(BuildContext context, int length, int current) {
  List<Widget> _list = [];

  for (int index = 0; index < length; index++) {
    Widget item = Container(
      width: 12.0,
      height: 12.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
      ),
    );

    _list.add(item);
  }

  return _list;
}
