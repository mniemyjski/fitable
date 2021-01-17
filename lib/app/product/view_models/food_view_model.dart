import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/models/recipe_model.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerFoodViewModel = ChangeNotifierProvider.autoDispose<FoodViewModel>((ref) {
  return FoodViewModel();
});

class FoodViewModel extends ChangeNotifier {
  int _calories;
  double _proteins;
  double _carbs;
  double _fats;
  double _portionSize;
  String _portionChosen;
  String _name;
  Map _portions;
  List _keyWords;

  build(Product product, Recipe recipe, Meal meal) {
    double multiplier;

    if (product != null) {
      _name = product.productName;
      _portions = product.portions;
      _keyWords = product.keyWords;
      _calories = product.calories;
      _proteins = product.proteins;
      _carbs = product.carbs;
      _fats = product.fats;
      if (_portionSize == null) _portionSize = 100.0;
      if (_portionChosen == null) _portionChosen = product.portions.keys.first;
      multiplier = _portions[_portionChosen];
    }
    if (recipe != null) {}
    if (meal != null) {
      _name = meal.product.productName;
      _portions = meal.product.portions;
      _keyWords = meal.product.keyWords;
      _calories = meal.product.calories;
      _proteins = meal.product.proteins;
      _carbs = meal.product.carbs;
      _fats = meal.product.fats;
      if (_portionSize == null) _portionSize = meal.portionSize;
      if (_portionChosen == null) _portionChosen = meal.portionChosen;
      multiplier = _portions[_portionChosen];
    }

    _calories = (_calories * _portionSize * multiplier / 100).round();
    _proteins = _proteins * _portionSize * multiplier / 100;
    _carbs = _carbs * _portionSize * multiplier / 100;
    _fats = _fats * _portionSize * multiplier / 100;
  }

  submit({@required BuildContext context, Product product, Meal meal, @required MealType mealType}) {
    final db = context.read(providerDatabase);
    final model = context.read(providerFoodViewModel);
    final modelHome = context.read(providerHomeViewModel);

    if (product != null) {
      Meal _meal = Meal(
          uid: db.uid,
          dateTime: modelHome.chosenDate,
          dateCreation: DateTime.now(),
          mealType: mealType,
          portionSize: model.portionSize,
          portionChosen: model.portionChosen,
          product: product);
      db.setMeal(meal: _meal);
    }

    if (meal != null) {
      db.updateMeal(meal: meal, portionSize: _portionSize, portionChosen: _portionChosen);
    }

    Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (_) => false);
  }

  bugReport() {}

  set portionSize(double portionSize) {
    _portionSize = portionSize;
    notifyListeners();
  }

  set portionChosen(String portionSize) {
    _portionChosen = portionSize;
    notifyListeners();
  }

  List get keyWords => _keyWords;
  String get name => _name;
  Map get portions => _portions;
  String get portionChosen => _portionChosen;
  double get portionSize => _portionSize;
  int get calories => _calories;
  double get proteins => _proteins;
  double get carbs => _carbs;
  double get fats => _fats;
}
