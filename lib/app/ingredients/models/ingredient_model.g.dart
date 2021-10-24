// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ingredient _$$_IngredientFromJson(Map<String, dynamic> json) =>
    _$_Ingredient(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
      selectedPortion:
          Portion.fromJson(json['selectedPortion'] as Map<String, dynamic>),
      size: (json['size'] as num).toDouble(),
    );

Map<String, dynamic> _$$_IngredientToJson(_$_Ingredient instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
      'recipe': instance.recipe.toJson(),
      'selectedPortion': instance.selectedPortion.toJson(),
      'size': instance.size,
    };
