import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

enum ETypeTabBar { food, workout }

TabBar customTabBar({
  required TabController controller,
  required ValueChanged<int>? onTap,
  required ETypeTabBar eTypeTabBar,
}) {
  if (eTypeTabBar == ETypeTabBar.food)
    return TabBar(
      controller: controller,
      onTap: onTap,
      tabs: <Widget>[
        Tab(text: Strings.products()),
        Tab(text: Strings.recipes()),
        Tab(text: Strings.your_workouts()),
      ],
    );

  return TabBar(
    controller: controller,
    onTap: onTap,
    tabs: <Widget>[
      Tab(text: Strings.exercises()),
      Tab(text: Strings.workouts()),
      Tab(text: Strings.your_workouts()),
    ],
  );
}
