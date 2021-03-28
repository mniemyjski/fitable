import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

buildMainAppBar(BuildContext context, String name) {
  return AppBar(
    title: Text(name),
    actions: [
      IconButton(
        icon: Icon(FontAwesomeIcons.envelope),
        onPressed: () => Navigator.pushNamed(context, AppRoute.massages),
      ),
      IconButton(
        icon: Icon(FontAwesomeIcons.bell),
        onPressed: () => Navigator.pushNamed(context, AppRoute.notifications),
      ),
    ],
  );
}
