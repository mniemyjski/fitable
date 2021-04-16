import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enum.dart';
import 'package:flutter/material.dart';

buildTab(SearchViewModel model) {
  switch (model.favoriteScreen) {
    case FavoriteScreen.onlyProducts:
      model.tabBar = [
        Tab(text: Constants.products()),
      ];
      break;
    case FavoriteScreen.allFoods:
      model.tabBar = [
        Tab(text: Constants.products()),
        Tab(text: Constants.recipes()),
        Tab(text: Constants.your_recipes()),
      ];
      break;
    case FavoriteScreen.workouts:
      model.tabBar = [
        Tab(text: Constants.exercises()),
        Tab(text: Constants.workouts()),
      ];
      break;
    case FavoriteScreen.accounts:
      model.tabBar = [
        Tab(text: Constants.followed()),
        Tab(text: Constants.followers()),
      ];
      break;
  }
}
