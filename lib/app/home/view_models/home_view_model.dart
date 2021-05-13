import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/product_details_screen.dart';
import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerHomeViewModel = ChangeNotifierProvider.autoDispose<HomeViewModel>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends ChangeNotifier {
  int _calories;
  double _proteins;
  double _carbs;
  double _fats;
  int _goalCalories;
  double _goalProteins;
  double _goalCarbs;
  double _goalFats;

  double get goalProteins => _goalProteins;
  double get goalCarbs => _goalCarbs;
  int get goalCalories => _goalCalories;
  double get goalFats => _goalFats;
  int get calories => _calories;
  double get proteins => _proteins;
  double get carbs => _carbs;
  double get fats => _fats;

  set mealList(List<Meal> mealList) {
    _calories = 0;
    _proteins = 0.0;
    _carbs = 0.0;
    _fats = 0.0;

    mealList.forEach((element) {
      _calories += element.getCalories();
      _proteins += element.getProteins();
      _carbs += element.getCarbs();
      _fats += element.getFats();
    });
  }

  onPressed(BuildContext context, Meal element, MealType mealType) async {
    final db = context.read(providerDatabase);
    dynamic result;

    if (element.isSuggested) {
      db.updateSuggested(meal: element, suggested: false);
      return;
    }

    if (element.ingredient.product != null) {
      result = await Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
          arguments: ProductDetailsScreenArguments(
            element: element.ingredient,
            isMeal: true,
          ));
    }

    if (element.ingredient.recipe != null) {
      result = await Navigator.of(context).pushNamed(AppRoute.recipeDetailsScreen,
          arguments: RecipeDetailsScreenArguments(
            element: element.ingredient,
            isMeal: true,
          ));
    }

    if (result != null) {
      Ingredient ingredient = result;

      db.updateMeal(meal: element, ingredient: ingredient);
    }
  }

  onDismissed(BuildContext context, dynamic element) {
    context.read(providerDatabase).deleteMeal(element);
  }

  onSearch(BuildContext context, MealType mealType) async {
    final db = context.read(providerDatabase);
    final app = context.read(providerAppViewModel);

    dynamic result = await Navigator.of(context).pushNamed(
      AppRoute.searchScreen,
      arguments: SearchScreenArguments(favoriteScreen: FavoriteScreen.allFoods, title: Enums.toText(mealType).tr()),
    );

    if (result != null) {
      Ingredient ingredient = result;
      db.addMeal(meal: Meal(dateTime: app.chosenDate, mealType: mealType, ingredient: ingredient));
    }
  }

  calculateBMR({@required BuildContext context, double weight, double fat}) {
    //TODO Move calculateBMR to other place

    final preference = context.read(providerPreference);
    final account = context.read(providerAccount);

    preference.whenData((preference) => account.whenData((account) {
          double age = account.age();
          double activities = _activities(preference.dayTimeActivities);
          double _weight = weight == null ? preference.lastBodyWeightValue : weight;
          double _fat = fat == null ? preference.lastBodyFatValue : fat;
          double ppm;

          if (preference.formulaBMR == 'advanced') {
            ppm = (370 + 21.6 * (_weight * (1 - _fat / 100))) * activities;
          } else {
            ppm = ((10 * _weight) + (6.25 * account.height) - (5 * age) + (account.gender == 'male' ? 5 : -161)) * activities;
          }

          if (preference.formulaBMR == 'advanced') {
            if (preference.targetFat.floorToDouble() == preference.lastBodyFatValue.floorToDouble()) {
              context.read(providerDatabase).updatePreference(name: 'speedChangeWeight', value: 0.0);
            }
            ppm = _fat < preference.targetFat ? ppm + (preference.speedChangeWeight * 400) : ppm - (preference.speedChangeWeight * 400);
          } else if (preference.formulaBMR == 'standard') {
            if (preference.targetWeight.floorToDouble() == preference.lastBodyWeightValue.floorToDouble()) {
              context.read(providerDatabase).updatePreference(name: 'speedChangeWeight', value: 0.0);
            }
            ppm = _weight < preference.targetWeight ? ppm + (preference.speedChangeWeight * 400) : ppm - (preference.speedChangeWeight * 400);
          }

          _goalCalories = ppm.round();
          _goalProteins = ppm * (preference.goalProteins / 100) / 4;
          _goalCarbs = ppm * (preference.goalCarbs / 100) / 4;
          _goalFats = ppm * (preference.goalFats / 100) / 9;
        }));
  }

  static double _activities(String value) {
    switch (value) {
      case 'very_low':
        return 1.2;
      case 'low':
        return 1.3;
      case 'normal':
        return 1.5;
      case 'medium':
        return 1.75;
      case 'high':
        return 2.0;
      default:
        return null;
    }
  }
}
