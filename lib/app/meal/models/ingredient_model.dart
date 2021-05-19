import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

class Ingredient {
  final Product product;
  final Recipe recipe;
  final Portion selectedPortion;
  final double size;

  Ingredient({this.product, this.recipe, @required this.selectedPortion, @required this.size});

  Map<String, dynamic> toMap() {
    return {
      'product': product?.toMap() ?? null,
      'recipe': recipe?.toMap() ?? null,
      'selectedPortion': selectedPortion.toMap(),
      'size': size,
    };
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

  List<Ingredient> toList() => [Ingredient(product: product, selectedPortion: selectedPortion, size: size)];

  static List toListMap(List ingredients) {
    List _ingredients = [];
    ingredients.forEach((element) {
      _ingredients.add(element.toMap());
    });
    return _ingredients;
  }

  static List<Ingredient> toListIngredient(List ingredients) {
    List<Ingredient> _ingredients = [];
    ingredients.forEach((element) {
      _ingredients.add(Ingredient.fromMap(element));
    });

    return _ingredients;
  }

  static Ingredient transform(dynamic element) {
    if (element.runtimeType == Product) return Ingredient(product: element, selectedPortion: element.portions.first, size: 100);
    if (element.runtimeType == Recipe) return Ingredient(recipe: element, selectedPortion: element.portions.first, size: 100);
    if (element.runtimeType == Ingredient) return element;

    return null;
  }

  String getName() {
    if (product != null) return product.name;
    if (recipe != null) return recipe.name;
    return '';
  }

  double getSize() {
    return size * selectedPortion.size;
  }

  String getId() {
    if (product != null) return product.id;
    if (recipe != null) return product.id;
    return '';
  }

  String getUnit() {
    return Enums.toText(getPortions().first.unit);
  }

  String getSelectedPortion() {
    return Enums.toText(selectedPortion.unit);
  }

  String getPortionName() {
    return '${size * selectedPortion.size}';
  }

  List<Portion> getPortions() {
    if (product != null) return product.portions;
    if (recipe != null) return recipe.portions;
    return [];
  }

  List<String> getPortionsStrings() {
    if (product != null) return product.getPortionsStrings();
    if (recipe != null) return recipe.getPortionsStrings();
    return [];
  }

  List<String> getKeyWords() {
    if (product != null) return product.keyWords;
    if (recipe != null) return recipe.keyWords;
    return [];
  }

  int getCalories({double portionSize, double selectedSize}) {
    if (recipe != null) {
      return recipe.getCalories(portionSize ?? size, selectedSize ?? selectedPortion.size);
    }

    return product.getCalories(portionSize ?? size, selectedSize ?? selectedPortion.size);
  }

  double getProteins({double portionSize, double selectedSize}) {
    if (recipe != null) {
      return recipe.getProteins(portionSize ?? size, selectedSize ?? selectedPortion.size);
    }
    return product.getProteins(portionSize ?? size, selectedSize ?? selectedPortion.size);
  }

  double getCarbs({double portionSize, double selectedSize}) {
    if (recipe != null) {
      return recipe.getCarbs(portionSize ?? size, selectedSize ?? selectedPortion.size);
    }
    return product.getCarbs(portionSize ?? size, selectedSize ?? selectedPortion.size);
  }

  double getFats({double portionSize, double selectedSize}) {
    if (recipe != null) {
      return recipe.getFats(portionSize ?? size, selectedSize ?? selectedPortion.size);
    }
    return product.getFats(portionSize ?? size, selectedSize ?? selectedPortion.size);
  }
}
