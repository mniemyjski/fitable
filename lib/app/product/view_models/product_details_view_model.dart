import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/product_create_screen.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerProductDetailsViewModel = ChangeNotifierProvider.autoDispose<ProductDetailsViewModel>((ref) {
  return ProductDetailsViewModel();
});

class ProductDetailsViewModel extends ChangeNotifier {
  String _id;
  int _calories;
  double _proteins;
  double _carbs;
  double _fats;
  double _portionSize;
  String _portionChosen;
  String _name;
  Map _portions;
  List _keyWords;
  bool _isFavorite;

  bool get isFavorite => _isFavorite;
  String get id => _id;

  build(Product product, Recipe recipe, Meal meal, List<Favorite> favorites) {
    double multiplier;

    if (product != null) {
      _id = product.id;
      _name = product.name;
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
    if (meal?.product != null) {
      _id = meal.product.id;
      _name = meal.product.name;
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

    _isFavorite = false;

    favorites.forEach((element) {
      if (element.id == _id) {
        _isFavorite = true;
      }
    });
  }

  submit({@required BuildContext context, Product product, Meal meal, @required MealType mealType}) {
    final db = context.read(providerDatabase);
    final model = context.read(providerProductDetailsViewModel);
    final app = context.read(providerAppViewModel);

    if (product != null) {
      Meal _meal = Meal(
          uid: db.uid,
          dateTime: app.chosenDate,
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

  bugReport(BuildContext context, Product product) {
    Navigator.of(context)
        .pushNamed(AppRoute.createProductScreen, arguments: ProductCreateScreenArguments(product: product, barcode: product.barcode));
  }

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
