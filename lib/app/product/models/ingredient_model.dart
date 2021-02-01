import 'package:fitable/app/product/models/product_model.dart';
import 'package:flutter/material.dart';

class Ingredient {
  final Product product;
  final double portionSize;
  final String portionChosen;

  Ingredient({this.product, @required this.portionSize, @required this.portionChosen});

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'portionSize': portionSize,
      'portionChosen': portionChosen,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    return Ingredient(
      product: Product.fromMap(data['product']),
      portionSize: data['portionSize'],
      portionChosen: data['portionChosen'],
    );
  }
}
