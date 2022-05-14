import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utilities/converter.dart';
import '../portions/portion_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

// fruits_vegetables_mushrooms,"Owoce, warzywa i grzyby",fruits_vegetables_mushrooms
// dairy_eggs,Nabiał i jaja,"Diary and eggs "
// meat,Mięso,Meat
// groceries,Artykuły spożywcze,Groceries
// frozen_foods,Mrożonki,Frozen foods
// supplements,Suplementy,Supplements
// drinks,Napoje,Drinks
// other,Inne,Other
// fruits,Owoce,Fruits
// vegetables,Warzywa,Vegetables
// mushrooms,Grzyby,Mushrooms
// milk_cream,Melko i śmietana," Milk and cream"
// butter_margarine,Masło i margaryna,Butter and margarine
// yogurt_desserts,Jogurty i serki," Yogurt and desserts"
// cheeses,Sery,Cheeses
// cottage_cheeses,Serki wiejskie,Cottage cheeses
// eggs,Jaja,Eggs
// poultry,Drób,Poultry
// beef,Wołowina,Beef
// pork,Wieprzowina,Pork
// rabbit,Królik,Rabbit
// venison,Dziczyzna,Venison
// fishes_seafood,Owoce morza,Fishes seafood
// sausages,Wędlina i kiełbasy,Sausages
// ready_meals,Gotowe produkty,Ready meals
// canned,Konserwy,Canned
// preserves,Przetwory,Preserves
// spices,Przyprawy,Spices
// sauces_oils_vinegar,Sosy oleje i oliwa z oliwek,Sauces oils vinegar
// loose_grain_products,Produkty sypkie i zbożowe,Loose grain products
// snacks_sweets,Słodkie przekąski,Snacks sweets
// bread,Chleb,Bread
// ready_meals,Produkty gotowe,Ready meals
// fishes_seafood,Ryby,Fishes seafood
// vegetables_fruits,Owoce i warzywa,Vegetables fruits

enum ETypeLocaleBase { pl, en }

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String barcode,
    required bool withBarcode,
    required String name,
    required String categoryPrimary,
    required String categorySecondary,
    required ETypeLocaleBase localeBase,
    required List<String> keyWords,
    required List<Portion> portions,
    required bool verification,
    required int calories,
    required double proteins,
    required double carbs,
    required double fats,
    @DateTimeConverter() required DateTime dateCreation,
    @DateTimeConverter() required DateTime dateLastUpdate,
    required List<String> photosUrl,
    required String company,
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

  const factory Product.buildEmpty({
    @Default('') String id,
    @Default('') String barcode,
    required bool withBarcode,
    @Default('') String name,
    @Default('') String categoryPrimary,
    @Default('') String categorySecondary,
    @Default(ETypeLocaleBase.pl) ETypeLocaleBase localeBase,
    @Default(<String>[]) List<String> keyWords,
    @PortionConverter() @Default(<Portion>[]) List<Portion> portions,
    @Default(false) bool verification,
    @Default(0) int calories,
    @Default(0.0) double proteins,
    @Default(0.0) double carbs,
    @Default(0.0) double fats,
    @DateTimeConverter() required DateTime dateCreation,
    @DateTimeConverter() required DateTime dateLastUpdate,
    @Default(<String>[]) List<String> photosUrl,
    @Default('') String company,
    @Default(0.0) double sugar,
    @Default(0.0) double animalProteins,
    @Default(0.0) double plantProteins,
    @Default(0.0) double saturated,
    @Default(0.0) double unsaturated,
    @Default(0.0) double omega3,
    @Default(0.0) double omega6,
    @Default(0.0) double fiber,
    @Default(0.0) double caffeine,
    @Default(0.0) double cholesterol,
    @Default(0.0) double salt,
    @Default(0.0) double vitaminA,
    @Default(0.0) double vitaminC,
    @Default(0.0) double vitaminD,
    @Default(0.0) double vitaminE,
    @Default(0.0) double vitaminK,
    @Default(0.0) double vitaminB1,
    @Default(0.0) double vitaminB2,
    @Default(0.0) double vitaminB3,
    @Default(0.0) double vitaminB5,
    @Default(0.0) double vitaminB6,
    @Default(0.0) double vitaminB7,
    @Default(0.0) double vitaminB9,
    @Default(0.0) double vitaminB12,
    @Default(0.0) double potassium,
    @Default(0.0) double sodium,
    @Default(0.0) double calcium,
    @Default(0.0) double magnesium,
    @Default(0.0) double phosphorus,
    @Default(0.0) double iron,
    @Default(0.0) double copper,
    @Default(0.0) double zinc,
    @Default(0.0) double selenium,
    @Default(0.0) double manganese,
    @Default(0.0) double iodine,
    @Default(0.0) double chromium,
  }) = Build;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
