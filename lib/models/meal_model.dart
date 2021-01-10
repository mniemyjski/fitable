import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum MealType { breakfast, lunch, dinner, supper, snack }

class Meal {
  final String uid;
  final Timestamp dateTime;
  final Timestamp dateCreation;
  final MealType mealType;
  final String id;
  final DocumentSnapshot documentMeal;

  // final Product product;
  // final Recipe recipe;
  final double portionSize;
  final String portionChosen;
  final bool suggest;

  Meal({
    @required this.uid,
    @required this.dateTime,
    @required this.dateCreation,
    @required this.mealType,
    @required this.id,
    @required this.documentMeal,
    @required this.portionSize,
    @required this.portionChosen,
    // this.product,
    // this.recipe,
    this.suggest = false,
  });

  // factory Meal.fromFirestore(DocumentSnapshot document) {
  //   Map data = document.data;
  //
  //   return Meal(
  //     uid: data['uid'],
  //     dateTime: data['dateTime'],
  //     dateCreation: data['dateCreation'],
  //     mealType: mealTypeToEnum(data['mealType']),
  //     id: document.documentID,
  //     documentMeal: document,
  //     product: data['product'] != null ? Product.fromMap(data['product']) : null,
  //     recipe: data['recipe'] != null ? Recipe.fromMap(data['recipe']) : null,
  //     portionSize: data['portionSize'],
  //     portionChosen: data['portionChosen'],
  //     suggest: data['suggest'],
  //   );
  // }

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
