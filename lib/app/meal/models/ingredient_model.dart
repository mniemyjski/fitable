import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:flutter/material.dart';

class Ingredient {
  final Product product;
  final Recipe recipe;
  final Portion selectedPortion;
  final double size;

  Ingredient({this.product, this.recipe, @required this.selectedPortion, @required this.size});

  Map<String, dynamic> toMap() {
    if (product != null) {
      return {
        'product': product.toMap(),
        'selectedPortion': selectedPortion.toMap(),
        'size': size,
      };
    } else {
      return {
        'recipe': recipe.toMap(),
        'selectedPortion': selectedPortion.toMap(),
        'size': size,
      };
    }
  }

  factory Ingredient.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return Ingredient(
        product: Product.fromMap(data['product']),
        recipe: Recipe.fromMap(data['recipe']),
        selectedPortion: Portion.fromMap(data['selectedPortion']),
        size: data['size']);
  }

  List<Ingredient> toList() {
    List<Ingredient> list = [];
    Ingredient ingredient = Ingredient(
      product: product,
      selectedPortion: selectedPortion,
      size: size,
    );
    list.add(ingredient);
    return list;
  }
}
