import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/models/recipe_model.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MealType { breakfast, lunch, dinner, supper, snack }

final providerMeals = StreamProvider<List<Meal>>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamMeals();
});

class Meal {
  final String id;
  final String uid;
  final DateTime dateTime;
  final DateTime dateCreation;
  final MealType mealType;
  final Product product;
  final Recipe recipe;
  final double portionSize;
  final String portionChosen;
  final bool suggest;

  Meal({
    this.id,
    @required this.uid,
    @required this.dateTime,
    @required this.dateCreation,
    @required this.mealType,
    @required this.portionSize,
    @required this.portionChosen,
    this.product,
    this.recipe,
    this.suggest = false,
  });

  Map<String, dynamic> toMap(String id) {
    return {
      'id': id,
      'uid': uid,
      'dateTime': DateTime(dateTime.year, dateTime.month, dateTime.day),
      'dateCreation': dateCreation,
      'mealType': mealTypeString(mealType),
      'portionSize': portionSize,
      'portionChosen': portionChosen,
      'product': product?.toMap(),
      'recipe': recipe?.toMap(),
      'suggest': suggest,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) {
      return null;
    }

    MealType toEnum(String mealType) {
      switch (mealType) {
        case 'breakfast':
          return MealType.breakfast;
        case 'lunch':
          return MealType.lunch;
        case 'dinner':
          return MealType.dinner;
        case 'supper':
          return MealType.supper;
        case 'snack':
          return MealType.snack;
        default:
          return null;
      }
    }

    Map map = data['product'];

    return Meal(
      uid: data['uid'],
      dateTime: data['dateTime'].toDate(),
      dateCreation: data['dateCreation'].toDate(),
      mealType: toEnum(data['mealType']),
      id: id,
      portionSize: data['portionSize'],
      portionChosen: data['portionChosen'],
      product: Product.fromMap(map, map['productID']),
    );
  }

  static String mealTypeString(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return 'breakfast';
      case MealType.lunch:
        return 'lunch';
      case MealType.dinner:
        return 'dinner';
      case MealType.supper:
        return 'supper';
      case MealType.snack:
        return 'snack';
      default:
        return null;
    }
  }
}
