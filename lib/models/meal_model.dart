import 'package:equatable/equatable.dart';
import 'package:fitable/models/ingredient_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Meal extends Equatable {
  const Meal({
    this.id,
    this.uid,
    this.dateCreation,
    @required this.dateTime,
    @required this.mealType,
    @required this.ingredient,
    this.isSuggested = false,
  });

  final String id;
  final String uid;
  final DateTime dateTime;
  final DateTime dateCreation;
  final ETypeMeal mealType;
  final Ingredient ingredient;
  final bool isSuggested;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

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
        mealType: Enums.toEnum(data['mealType'], ETypeMeal.values),
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

  Meal copyWith({
    String id,
    String uid,
    DateTime dateTime,
    DateTime dateCreation,
    ETypeMeal mealType,
    Ingredient ingredient,
    bool isSuggested,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (uid == null || identical(uid, this.uid)) &&
        (dateTime == null || identical(dateTime, this.dateTime)) &&
        (dateCreation == null || identical(dateCreation, this.dateCreation)) &&
        (mealType == null || identical(mealType, this.mealType)) &&
        (ingredient == null || identical(ingredient, this.ingredient)) &&
        (isSuggested == null || identical(isSuggested, this.isSuggested))) {
      return this;
    }

    return new Meal(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      dateTime: dateTime ?? this.dateTime,
      dateCreation: dateCreation ?? this.dateCreation,
      mealType: mealType ?? this.mealType,
      ingredient: ingredient ?? this.ingredient,
      isSuggested: isSuggested ?? this.isSuggested,
    );
  }
}
