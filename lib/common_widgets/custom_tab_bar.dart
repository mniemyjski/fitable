import 'package:flutter/material.dart';

class CustomTabBar extends Container implements PreferredSizeWidget {
  CustomTabBar({@required this.color, @required this.tabBar});

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            color: Theme.of(context).primaryColorDark,
            child: Container(height: 1),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Container(height: 2),
          ),
          tabBar,
        ],
      );
}
