import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

buildMainAppBar(String name) {
  return AppBar(
    title: Text(name),
    actions: [
      IconButton(icon: Icon(FontAwesomeIcons.envelope), onPressed: () => null),
      IconButton(icon: Icon(FontAwesomeIcons.bell), onPressed: () => null),
    ],
  );
}
