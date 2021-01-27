import 'package:flutter/material.dart';

class Product {
  final String id;
  final String barcode;
  final String name;
  final String categoryPrimary;
  final String categorySecondary;
  final String localeBase;
  final List keyWords;
  final Map portions;
  final String unit;
  final bool verification;
  final Map photosUrl;
  final int calories;
  final double proteins, carbs, fats;
  final double sugar, animalProteins, plantProteins, saturated, unsaturated, omega3, omega6;
  final double fiber, caffeine, cholesterol, salt;
  final double vitaminA, vitaminC, vitaminD, vitaminE, vitaminK;
  final double vitaminB1, vitaminB2, vitaminB3, vitaminB5, vitaminB6, vitaminB7, vitaminB9, vitaminB12;
  final double potassium, sodium, calcium, magnesium, phosphorus;
  final double iron, copper, zinc, selenium, manganese, iodine, chromium;

  Product(
      {this.id,
      @required this.barcode,
      @required this.name,
      @required this.categoryPrimary,
      @required this.categorySecondary,
      @required this.localeBase,
      @required this.keyWords,
      @required this.portions,
      @required this.unit,
      @required this.verification,
      @required this.calories,
      @required this.proteins,
      @required this.carbs,
      @required this.fats,
      @required this.photosUrl,
      @required this.sugar,
      @required this.animalProteins,
      @required this.plantProteins,
      @required this.saturated,
      @required this.unsaturated,
      @required this.omega3,
      @required this.omega6,
      @required this.fiber,
      @required this.caffeine,
      @required this.cholesterol,
      @required this.salt,
      @required this.vitaminA,
      @required this.vitaminC,
      @required this.vitaminD,
      @required this.vitaminE,
      @required this.vitaminK,
      @required this.vitaminB1,
      @required this.vitaminB2,
      @required this.vitaminB3,
      @required this.vitaminB5,
      @required this.vitaminB6,
      @required this.vitaminB7,
      @required this.vitaminB9,
      @required this.vitaminB12,
      @required this.potassium,
      @required this.sodium,
      @required this.calcium,
      @required this.magnesium,
      @required this.phosphorus,
      @required this.iron,
      @required this.copper,
      @required this.zinc,
      @required this.selenium,
      @required this.manganese,
      @required this.iodine,
      @required this.chromium});

  Map<String, dynamic> toMap({String id}) {
    return {
      'id': id ?? this.id,
      'barcode': barcode,
      'name': name,
      'categoryPrimary': categoryPrimary,
      'categorySecondary': categorySecondary,
      'localeBase': localeBase,
      'keyWords': keyWords,
      'portions': portions,
      'unit': unit,
      'verification': verification,
      'calories': calories,
      'proteins': proteins,
      'carbs': carbs,
      'fats': fats,
      'photosUrl': photosUrl,
      'sugar': sugar,
      'animalProteins': animalProteins,
      'plantProteins': plantProteins,
      'saturated': saturated,
      'unsaturated': unsaturated,
      'omega3': omega3,
      'omega6': omega6,
      'fiber': fiber,
      'caffeine': caffeine,
      'cholesterol': cholesterol,
      'salt': salt,
      'vitaminA': vitaminA,
      'vitaminC': vitaminC,
      'vitaminD': vitaminD,
      'vitaminE': vitaminE,
      'vitaminK': vitaminK,
      'vitaminB1': vitaminB1,
      'vitaminB2': vitaminB2,
      'vitaminB3': vitaminB3,
      'vitaminB5': vitaminB5,
      'vitaminB6': vitaminB6,
      'vitaminB7': vitaminB7,
      'vitaminB9': vitaminB9,
      'vitaminB12': vitaminB12,
      'potassium': potassium,
      'sodium': sodium,
      'calcium': calcium,
      'magnesium': magnesium,
      'phosphorus': phosphorus,
      'iron': iron,
      'copper': copper,
      'zinc': zinc,
      'selenium': selenium,
      'manganese': manganese,
      'iodine': iodine,
      'chromium': chromium,
    };
  }

  factory Product.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return Product(
      id: data['id'],
      barcode: data['barcode'],
      name: data['name'],
      categoryPrimary: data['categoryPrimary'],
      categorySecondary: data['categorySecondary'],
      localeBase: data['localeBase'],
      keyWords: data['keyWords'],
      portions: data['portions'],
      unit: data['unit'],
      verification: data['verification'],
      calories: data['calories'],
      proteins: data['proteins'],
      carbs: data['carbs'],
      fats: data['fats'],
      sugar: data['sugar'],
      animalProteins: data['animalProteins'],
      plantProteins: data['plantProteins'],
      saturated: data['saturated'],
      unsaturated: data['unsaturated'],
      omega3: data['omega3'],
      omega6: data['omega6'],
      fiber: data['fiber'],
      caffeine: data['caffeine'],
      cholesterol: data['cholesterol'],
      salt: data['salt'],
      vitaminA: data['vitaminA'],
      vitaminC: data['vitaminC'],
      vitaminD: data['vitaminD'],
      vitaminE: data['vitaminE'],
      vitaminK: data['vitaminK'],
      vitaminB1: data['vitaminB1'],
      vitaminB2: data['vitaminB2'],
      vitaminB3: data['vitaminB3'],
      vitaminB5: data['vitaminB5'],
      vitaminB6: data['vitaminB6'],
      vitaminB7: data['vitaminB7'],
      vitaminB9: data['vitaminB9'],
      vitaminB12: data['vitaminB12'],
      potassium: data['potassium'],
      sodium: data['sodium'],
      calcium: data['calcium'],
      magnesium: data['magnesium'],
      phosphorus: data['phosphorus'],
      iron: data['iron'],
      copper: data['copper'],
      zinc: data['zinc'],
      selenium: data['selenium'],
      manganese: data['manganese'],
      iodine: data['iodine'],
      chromium: data['chromium'],
      photosUrl: {},
    );
  }
}
