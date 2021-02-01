import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerRecipeCreateViewModel = ChangeNotifierProvider.autoDispose<RecipeCreateViewModel>((ref) {
  return RecipeCreateViewModel();
});

class RecipeCreateViewModel extends ChangeNotifier {
  List<Ingredient> ingredients = [];
  int calories = 0;
  double proteins = 0;
  double carbs = 0;
  double fats = 0;

  onPressed(BuildContext context, dynamic element) {
    // Navigator.of(context).pushNamed(AppRoute.productDetailsScreen,
    //     arguments: ProductDetailsScreenArguments(
    //       meal: element,
    //       mealType: mealType,
    //     ));
  }

  onDismissed(BuildContext context, dynamic element) {
    // context.read(providerDatabase).deleteMeal(element);
  }

  onSearch(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoute.searchScreen, arguments: SearchScreenArguments(typeSearch: SearchType.onlyProducts));
  }
}
