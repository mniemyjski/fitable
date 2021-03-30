import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/product_details_screen.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:fitable/app/recipe/recipe_details_screen.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerRecipeDetailsViewModel = ChangeNotifierProvider.autoDispose<RecipeDetailsViewModel>((ref) {
  return RecipeDetailsViewModel();
});

class RecipeDetailsViewModel extends ChangeNotifier {
  String _id;
  int _calories;
  double _proteins;
  double _carbs;
  double _fats;
  double _portionSize;
  String _portionChosen;
  Map _portions;
  bool _isFavorite = false;
  List<String> listMealType = ['breakfast', 'lunch', 'dinner', 'supper', 'snack'];
  MealType _mealType = MealType.breakfast;

  chooseMealType(String mealType) {
    _mealType = Meal.toEnum(mealType);
    notifyListeners();
  }

  String getMealTypeString() {
    return Meal.toText(_mealType);
  }

  Map get portions => _portions;
  String get portionChosen => _portionChosen;
  double get portionSize => _portionSize;
  int get calories => _calories;
  double get proteins => _proteins;
  double get carbs => _carbs;
  double get fats => _fats;
  bool get isFavorite => _isFavorite;
  String get id => _id;

  bool _createScreen = true;
  bool get createScreen => _createScreen;

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

  submit({@required BuildContext context}) {
    final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
    Ingredient result = Ingredient(portionSize: _portionSize, portionChosen: _portionChosen, recipe: args.recipe);

    if (args.chooseMealType) {
      final db = context.read(providerDatabase);
      final app = context.read(providerAppViewModel);

      Meal _meal = Meal(
          uid: db.uid,
          dateTime: app.chosenDate,
          dateCreation: DateTime.now(),
          mealType: _mealType,
          portionSize: _portionSize,
          portionChosen: _portionChosen,
          recipe: args.recipe);
      db.setMeal(meal: _meal);
      Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (_) => false);
    } else {
      Navigator.pop(context, result);
    }
  }

  submitFavorite(BuildContext context, String id) {
    Favorite _favorite = Favorite(type: EnumFavorite.recipes, id: id);
    context.read(providerDatabase).updateFavorite(context, _favorite);
  }

  seeProduct(BuildContext context, Ingredient ingredient) async {
    Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
        arguments: ProductDetailsScreenArguments(
          ingredient: ingredient,
          edit: false,
        ));
  }

  build(Recipe recipe, List<Favorite> favorites) {
    double multiplier;

    _createScreen = true;

    _id = recipe.id;
    _portions = recipe.portions;

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

    _createScreen = false;
  }
}
