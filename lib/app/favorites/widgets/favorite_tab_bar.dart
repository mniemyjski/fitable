import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/material.dart';

enum ETypeTabBar { food, workout }

favoriteTabBar({
  required TabController controller,
  required ValueChanged<int>? onTap,
  required ETypeTabBar eTypeTabBar,
}) {
  if (eTypeTabBar == ETypeTabBar.food)
    return TabBar(
      controller: controller,
      onTap: onTap,
      tabs: <Widget>[
        Builder(builder: (context) => Tab(text: AppLocalizations.of(context)!.products)),
        Builder(builder: (context) => Tab(text: AppLocalizations.of(context)!.recipes)),
        Builder(builder: (context) => Tab(text: AppLocalizations.of(context)!.yourRecipes)),
      ],
    );

  return TabBar(
    controller: controller,
    onTap: onTap,
    tabs: <Widget>[
      Builder(builder: (context) => Tab(text: AppLocalizations.of(context)!.exercises)),
      Builder(builder: (context) => Tab(text: AppLocalizations.of(context)!.workouts)),
      Builder(builder: (context) => Tab(text: AppLocalizations.of(context)!.yourWorkouts)),
    ],
  );
}
