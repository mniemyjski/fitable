import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String barcode,
    required String name,
    required String categoryPrimary,
    required String categorySecondary,
    required String localeBase,
    required List<String> keyWords,
    required List<String> portions,
    required bool verification,
    required int calories,
    required double proteins,
    required double carbs,
    required double fats,
    required DateTime dateCreation,
    required DateTime dateLastUpdate,
    required String photosUrl,
    required double sugar,
    required double animalProteins,
    required double plantProteins,
    required double saturated,
    required double unsaturated,
    required double omega3,
    required double omega6,
    required double fiber,
    required double caffeine,
    required double cholesterol,
    required double salt,
    required double vitaminA,
    required double vitaminC,
    required double vitaminD,
    required double vitaminE,
    required double vitaminK,
    required double vitaminB1,
    required double vitaminB2,
    required double vitaminB3,
    required double vitaminB5,
    required double vitaminB6,
    required double vitaminB7,
    required double vitaminB9,
    required double vitaminB12,
    required double potassium,
    required double sodium,
    required double calcium,
    required double magnesium,
    required double phosphorus,
    required double iron,
    required double copper,
    required double zinc,
    required double selenium,
    required double manganese,
    required double iodine,
    required double chromium,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
