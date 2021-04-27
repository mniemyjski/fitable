import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
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
  final Ingredient ingredient;
  final bool suggest;

  Meal({
    this.id,
    this.uid,
    this.dateCreation,
    @required this.dateTime,
    @required this.mealType,
    @required this.ingredient,
    this.suggest = false,
  });

  Map<String, dynamic> toMap(String id) {
    return {
      'id': id,
      'uid': uid,
      'dateTime': DateTime(dateTime.year, dateTime.month, dateTime.day),
      'dateCreation': dateCreation == null ? DateTime.now() : dateCreation,
      'mealType': toText(mealType),
      'ingredient': ingredient.toMap(),
      'suggest': suggest,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) {
      return null;
    }

    return Meal(
        uid: data['uid'],
        dateTime: data['dateTime'].toDate(),
        dateCreation: data['dateCreation'].toDate(),
        mealType: toEnum(data['mealType']),
        id: id,
        ingredient: Ingredient.fromMap(data['ingredient']));
  }

  static toEnum(String mealType) {
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
    }
  }

  static String toText(MealType mealType) {
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
