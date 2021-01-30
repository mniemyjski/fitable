import 'package:fitable/app/product/models/product_model.dart';
import 'package:flutter/material.dart';

class Ingredients {
  final Product product;
  final double portionSize;
  final String portionChosen;

  Ingredients({this.product, @required this.portionSize, @required this.portionChosen});

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
      portionSize: null,
      portionChosen: null,
    );
  }
}
