import 'package:fitable/app/product/models/product_model.dart';
import 'package:flutter/material.dart';

class Ingredients {
  final Product product;
  final Product recipe;
  final double portionSize;
  final String portionChosen;

  Ingredients({this.recipe, this.product, @required this.portionSize, @required this.portionChosen});

  Map<String, dynamic> toMap() {
    return {
      'product': product,
    };
  }

  factory Ingredients.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    return Ingredients(
      product: null,
      recipe: null,
      portionSize: null,
      portionChosen: null,
    );
  }
}
