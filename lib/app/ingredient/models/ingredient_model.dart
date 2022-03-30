import 'package:fitable/app/portions/models/portion_model.dart';
import 'package:fitable/app/products/models/product_model.dart';
import 'package:fitable/app/recipes/models/recipe_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_model.freezed.dart';
part 'ingredient_model.g.dart';

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    required Product product,
    required Recipe recipe,
    required Portion selectedPortion,
    required double size,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
}
