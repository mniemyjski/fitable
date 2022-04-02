import 'package:auto_route/auto_route.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar customAppBar({String? title}) {
  return AppBar(
    title: Text(title ?? ''),
    actions: [
      Builder(
          builder: (context) => IconButton(
              onPressed: () => context.router.push(NotificationRoute()),
              icon: FaIcon(FontAwesomeIcons.bell))),
      Builder(
          builder: (context) => IconButton(
              onPressed: () => context.router.push(MassagesRoute()),
              icon: FaIcon(FontAwesomeIcons.envelope))),
      Builder(
          builder: (context) => IconButton(
              onPressed: () => context.router.push(CommunityRoute()),
              icon: FaIcon(FontAwesomeIcons.userGroup))),
    ],
  );
}
