import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

buildTab(SearchViewModel model) {
  switch (model.favoriteScreen) {
    case ETypeFavoriteScreen.onlyProducts:
      model.tabBar = [
        Tab(text: Languages.products()),
      ];
      break;
    case ETypeFavoriteScreen.allFoods:
      model.tabBar = [
        Tab(text: Languages.products()),
        Tab(text: Languages.recipes()),
        Tab(text: Languages.your_recipes()),
      ];
      break;
    case ETypeFavoriteScreen.workouts:
      model.tabBar = [
        Tab(text: Languages.exercises()),
        Tab(text: Languages.workouts()),
      ];
      break;
    case ETypeFavoriteScreen.accounts:
      model.tabBar = [
        Tab(text: Languages.followed()),
        Tab(text: Languages.followers()),
      ];
      break;
  }
}
