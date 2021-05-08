import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:fitable/app/meal/product_details_screen.dart';
import 'package:fitable/app/meal/recipe_create_screen.dart';
import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/utilities/macro.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerRecipeDetailsViewModel = ChangeNotifierProvider.autoDispose<RecipeDetailsViewModel>((ref) {
  return RecipeDetailsViewModel();
});

class RecipeDetailsViewModel extends ChangeNotifier {
  int _calories;
  double _proteins;
  double _carbs;
  double _fats;
  double _sizeListener;
  Portion _selectedPortion;
  bool _isFavorite = false;
  List<String> listMealType = ['breakfast', 'lunch', 'dinner', 'supper', 'snack'];
  MealType _mealType = MealType.breakfast;
  Recipe recipe;

  chooseMealType(String mealType) {
    _mealType = Meal.toEnum(mealType);
    notifyListeners();
  }

  String getMealTypeString() {
    return Meal.toText(_mealType);
  }

  Portion get selectedPortion => _selectedPortion;
  double get sizeListener => _sizeListener;
  int get calories => _calories;
  double get proteins => _proteins;
  double get carbs => _carbs;
  double get fats => _fats;
  bool get isFavorite => _isFavorite;
  bool initState = true;

  bool _createScreen = true;
  bool get createScreen => _createScreen;

  set sizeListener(double sizeListener) {
    _sizeListener = sizeListener != null ? sizeListener : Macro.getSize(recipe);
    notifyListeners();
  }

  setSelectedPortion(String name) {
    _selectedPortion = Macro.getPortions(recipe).firstWhere((element) => element.name == name);
    notifyListeners();
  }

  editRecipe(BuildContext context, Recipe recipe) {
    Navigator.pushNamed(context, AppRoute.recipeCreateScreen, arguments: RecipeCreateScreenArguments(recipe: recipe));
  }

  deleteRecipe(BuildContext context, Recipe recipe) {
    context.read(providerDatabase).deleteRecipe(recipe);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  submit({@required BuildContext context}) {
    final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
    Ingredient result = Ingredient(selectedPortion: selectedPortion, recipe: recipe, size: sizeListener);

    if (args.chooseMealType) {
      final db = context.read(providerDatabase);
      final app = context.read(providerAppViewModel);

      Meal _meal = Meal(
        uid: db.uid,
        dateTime: app.chosenDate,
        dateCreation: DateTime.now(),
        mealType: _mealType,
        ingredient: result,
      );
      db.addMeal(meal: _meal);
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
          element: ingredient,
          edit: false,
        ));
  }

  build(Recipe recipe, List<Favorite> favorites) {
    _createScreen = true;

    if (initState) {
      this.recipe = recipe;
      _sizeListener = Macro.getSize(recipe);
      _selectedPortion = Macro.getSelectedPortion(recipe);
      initState = false;
    }

    _calories = 0;
    _proteins = 0;
    _carbs = 0;
    _fats = 0;

    double _sizeTotal = 0;

    recipe.ingredients.forEach((element) {
      _sizeTotal += element.size;
    });

    recipe.ingredients.forEach((element) {
      _calories += Macro.calculateCalories(element, element.size * sizeListener * _selectedPortion.size / _sizeTotal, element.selectedPortion);
      _proteins += Macro.calculateProteins(element, element.size * sizeListener * _selectedPortion.size / _sizeTotal, element.selectedPortion);
      _carbs += Macro.calculateCarbs(element, element.size * sizeListener * _selectedPortion.size / _sizeTotal, element.selectedPortion);
      _fats += Macro.calculateFats(element, element.size * sizeListener * _selectedPortion.size / _sizeTotal, element.selectedPortion);
    });

    _isFavorite = false;

    favorites.forEach((e) {
      if (e.id == Macro.getId(recipe) && e.type == EnumFavorite.recipes) {
        _isFavorite = true;
      }
    });

    _createScreen = false;
  }
}
