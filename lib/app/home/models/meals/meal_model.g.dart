// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Meal _$$_MealFromJson(Map<String, dynamic> json) => _$_Meal(
      id: json['id'] as String,
      uid: json['uid'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      dateCreation: DateTime.parse(json['dateCreation'] as String),
      mealType: $enumDecode(_$ETypeMealEnumMap, json['mealType']),
      ingredient:
          Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
      isSuggested: json['isSuggested'] as bool,
    );

Map<String, dynamic> _$$_MealToJson(_$_Meal instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'dateTime': instance.dateTime.toIso8601String(),
      'dateCreation': instance.dateCreation.toIso8601String(),
      'mealType': _$ETypeMealEnumMap[instance.mealType],
      'ingredient': instance.ingredient.toJson(),
      'isSuggested': instance.isSuggested,
    };

const _$ETypeMealEnumMap = {
  ETypeMeal.breakfast: 'breakfast',
  ETypeMeal.lunch: 'lunch',
  ETypeMeal.dinner: 'dinner',
  ETypeMeal.supper: 'supper',
  ETypeMeal.snack: 'snack',
};
