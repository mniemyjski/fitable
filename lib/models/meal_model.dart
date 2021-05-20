import 'package:fitable/models/ingredient_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Meal {
  final String id;
  final String uid;
  final DateTime dateTime;
  final DateTime dateCreation;
  final TypeMeal mealType;
  final Ingredient ingredient;
  final bool isSuggested;

  Meal({
    this.id,
    this.uid,
    this.dateCreation,
    @required this.dateTime,
    @required this.mealType,
    @required this.ingredient,
    this.isSuggested = false,
  });

  Map<String, dynamic> toMap(String id, String uid) {
    return {
      'id': id,
      'uid': uid != null ? uid : this.uid,
      'dateTime': DateTime(dateTime.year, dateTime.month, dateTime.day),
      'dateCreation': dateCreation == null ? DateTime.now() : dateCreation,
      'mealType': Enums.toText(mealType),
      'ingredient': ingredient.toMap(),
      'isSuggested': isSuggested,
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
        mealType: Enums.toEnum(data['mealType'], TypeMeal.values),
        isSuggested: data['isSuggested'],
        id: id,
        ingredient: Ingredient.fromMap(data['ingredient']));
  }

  int getCalories() {
    if (!isSuggested) return ingredient.getCalories();
    return 0;
  }

  double getProteins() {
    if (!isSuggested) return ingredient.getCarbs();
    return 0;
  }

  double getCarbs() {
    if (!isSuggested) return ingredient.getCarbs();
    return 0;
  }

  double getFats() {
    if (!isSuggested) return ingredient.getFats();
    return 0;
  }

  delete() {}
  add() {}
  update() {}
}
