import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerRecipeDetailsViewModel = ChangeNotifierProvider.autoDispose<RecipeDetailsViewModel>((ref) {
  return RecipeDetailsViewModel();
});

class RecipeDetailsViewModel extends ChangeNotifier {
  String _id = "";
  int _calories;
  double _proteins;
  double _carbs;
  double _fats;
  double _portionSize;
  String _portionChosen;
  String _name = "";
  Map _portions;
  List _keyWords;
  bool _isFavorite = false;

  List get keyWords => _keyWords;
  String get name => _name;
  Map get portions => _portions;
  String get portionChosen => _portionChosen;
  double get portionSize => _portionSize;
  int get calories => _calories;
  double get proteins => _proteins;
  double get carbs => _carbs;
  double get fats => _fats;
  bool get isFavorite => _isFavorite;
  String get id => _id;

  set portionSize(double portionSize) {
    _portionSize = portionSize;
    notifyListeners();
  }

  set portionChosen(String portionSize) {
    _portionChosen = portionSize;
    notifyListeners();
  }

  bugReport(BuildContext context, Recipe recipe) {
    // Navigator.of(context)
    //     .pushNamed(AppRoute.createProductScreen, arguments: ProductCreateScreenArguments(product: product, barcode: product.barcode));
  }

  submit({@required BuildContext context, Recipe recipe}) {
    // final model = context.read(providerProductDetailsViewModel);
    //
    // Ingredient result = Ingredient(portionSize: model.portionSize, portionChosen: model.portionChosen, product: product);
    // Navigator.pop(context, result);
  }

  submitFavorite(BuildContext context, String id) {
    Favorite _favorite = Favorite(type: EnumFavorite.recipes, id: id);
    context.read(providerDatabase).updateFavorite(context, _favorite);
  }

  build(Recipe recipe, List<Favorite> favorites) {
    double multiplier;

    _id = recipe.id;
    _name = recipe.name;
    _portions = recipe.portions;
    _keyWords = recipe.keyWords;

    _calories = 0;
    _proteins = 0;
    _carbs = 0;
    _fats = 0;

    recipe.ingredients.forEach((element) {
      _calories = (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100).round();
      _proteins = element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100;
      _carbs = element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100;
      _fats = element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100;
    });

    if (_portionSize == null) _portionSize = 100.0;
    if (_portionChosen == null) _portionChosen = recipe.portions.keys.first;
    multiplier = _portions[_portionChosen];
    _calories = (_calories * _portionSize * multiplier / 100).round();
    _proteins = _proteins * _portionSize * multiplier / 100;
    _carbs = _carbs * _portionSize * multiplier / 100;
    _fats = _fats * _portionSize * multiplier / 100;

    _isFavorite = false;

    favorites.forEach((element) {
      if (element.id == _id && element.type == EnumFavorite.recipes) {
        _isFavorite = true;
      }
    });
  }
}
