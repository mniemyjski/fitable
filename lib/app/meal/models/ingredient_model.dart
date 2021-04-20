import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:flutter/material.dart';

class Ingredient {
  final Product product;
  final Recipe recipe;
  final double portionSize;
  final String portionChosen;

  Ingredient({this.product, this.recipe, @required this.portionSize, @required this.portionChosen});

  Map<String, dynamic> toMap() {
    if (product != null) {
      return {
        'product': product.toMap(),
        'portionSize': portionSize,
        'portionChosen': portionChosen,
      };
    } else {
      return {
        'recipe': recipe.toMap(),
        'portionSize': portionSize,
        'portionChosen': portionChosen,
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
      portionSize: data['portionSize'],
      portionChosen: data['portionChosen'],
    );
  }

  List<Ingredient> toList() {
    List<Ingredient> list = [];
    Ingredient ingredient = Ingredient(
      product: product,
      portionSize: portionSize,
      portionChosen: portionChosen,
    );
    list.add(ingredient);
    return list;
  }
}
