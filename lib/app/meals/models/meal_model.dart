import 'package:fitable/app/ingredients/models/ingredient_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_model.freezed.dart';
part 'meal_model.g.dart';

enum ETypeMeal { breakfast, lunch, dinner, supper, snack }

@freezed
class Meal with _$Meal {
  const factory Meal({
    required String id,
    required String uid,
    required DateTime dateTime,
    required DateTime dateCreation,
    required ETypeMeal mealType,
    required Ingredient ingredient,
    required bool isSuggested,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}
