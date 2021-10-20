import 'package:fitable/models/favorite_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/models/ingredient_model.dart';
import 'package:fitable/models/meal_model.dart';
import 'package:fitable/models/portion_model.dart';
import 'package:fitable/models/recipe_model.dart';
import 'package:fitable/app/meal/product_details_screen.dart';
import 'package:fitable/app/meal/recipe_create_screen.dart';
import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/services/favorite_service.dart';
import 'package:fitable/services/meals_service.dart';
import 'package:fitable/services/recipes_service.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  ETypeMeal _mealType = ETypeMeal.breakfast;
  Recipe recipe;

  chooseMealType(String mealType) {
    _mealType = Enums.toEnum(mealType, ETypeMeal.values);
    notifyListeners();
  }

  String getMealTypeString() {
    return Enums.toText(_mealType);
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
    _sizeListener = sizeListener != null ? sizeListener : 100;
    notifyListeners();
  }

  setSelectedPortion(String name) {
    _selectedPortion = recipe.portions.firstWhere((element) => element.name == name);
    notifyListeners();
  }

  editRecipe(BuildContext context, Recipe recipe) {
    Navigator.pushNamed(context, AppRoute.recipeCreateScreen, arguments: RecipeCreateScreenArguments(recipe: recipe));
  }

  deleteRecipe(BuildContext context, Recipe recipe) {
    context.read(providerRecipesService).deleteRecipe(recipe);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  submit({@required BuildContext context}) {
    final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
    Ingredient result = Ingredient(selectedPortion: selectedPortion, recipe: recipe, size: sizeListener);

    if (args.chooseMealType) {
      final app = context.read(providerAppViewModel);

      Meal _meal = Meal(
        // uid: db.uid,
        dateTime: app.chosenDate,
        dateCreation: DateTime.now(),
        mealType: _mealType,
        ingredient: result,
      );
      context.read(providerMealsService).addMeal(meal: _meal);
      Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (_) => false);
    } else {
      Navigator.pop(context, result);
    }
  }

  submitFavorite(BuildContext context, String id) {
    Favorite _favorite = Favorite(type: ETypeFavorite.recipes, id: id);
    context.read(providerFavoriteService).whenData((value) => value.updateFavorite(_favorite));
  }

  seeProduct(BuildContext context, Ingredient ingredient) async {
    Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
        arguments: ProductDetailsScreenArguments(
          element: ingredient,
          edit: false,
        ));
  }

  init(List<Favorite> favorites, Ingredient element) async {
    _createScreen = true;

    if (initState) {
      this.recipe = element.recipe;
      _sizeListener = element.size;
      _selectedPortion = element.selectedPortion;
      initState = false;
    }

    _calories = 0;
    _proteins = 0;
    _carbs = 0;
    _fats = 0;

    _calories += (recipe.getCalories(_sizeListener, _selectedPortion.size)).round();
    _proteins += recipe.getProteins(_sizeListener, _selectedPortion.size);
    _carbs += recipe.getCarbs(_sizeListener, _selectedPortion.size);
    _fats += recipe.getFats(_sizeListener, _selectedPortion.size);

    _isFavorite = false;

    favorites.forEach((e) {
      if (e.id == element.getId() && e.type == ETypeFavorite.recipes) _isFavorite = true;
    });

    _createScreen = false;
  }
}
