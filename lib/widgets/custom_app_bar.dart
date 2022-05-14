import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar customAppBar({String? title}) {
  return AppBar(
    title: Text(title ?? ''),
    actions: [
      Builder(builder: (context) {
        return _iconButton(
          icon: FontAwesomeIcons.bell,
          onPressed: () => context.router.push(
            NotificationRoute(),
          ),
        );
      }),
      Builder(builder: (context) {
        return _iconButton(
          icon: FontAwesomeIcons.envelope,
          onPressed: () => context.router.push(
            MassagesRoute(),
          ),
        );
      }),
      Builder(builder: (context) {
        return _iconButton(
          icon: FontAwesomeIcons.userGroup,
          onPressed: () => context.router.push(
            CommunityRoute(),
          ),
        );
      }),
    ],
  );
}

Padding _iconButton({required IconData icon, VoidCallback? onPressed}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: IconButton(
      onPressed: onPressed,
      icon: Badge(
        badgeContent: Text('0'),
        child: FaIcon(icon),
        showBadge: true,
      ),
    ),
  );
}
