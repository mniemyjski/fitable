import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar customAppBar({String? title}) {
  return AppBar(
    title: Text(title ?? ''),
    actions: [
      IconButton(onPressed: () => null, icon: FaIcon(FontAwesomeIcons.bell)),
      IconButton(onPressed: () => null, icon: FaIcon(FontAwesomeIcons.envelope)),
      IconButton(onPressed: () => null, icon: FaIcon(FontAwesomeIcons.userGroup)),
    ],
  );
}
