import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String productID;
  final String barcode;
  final String productName;
  final String categoryPrimary;
  final String categorySecondary;
  final String localeBase;
  final List keyWords;
  final Map portions;
  final String unit;
  final bool verification;
  final Map photosUrl;
  final double calories, proteins, carbs, fats;
  final double sugar, animalProteins, plantProteins, saturated, unsaturated, omega3, omega6;
  final double fiber, caffeine, cholesterol, salt;
  final double vitaminA, vitaminC, vitaminD, vitaminE, vitaminK;
  final double vitaminB1, vitaminB2, vitaminB3, vitaminB5, vitaminB6, vitaminB7, vitaminB9, vitaminB12;
  final double potassium, sodium, calcium, magnesium, phosphorus;
  final double iron, copper, zinc, selenium, manganese, iodine, chromium;

  Product(
      {@required this.productID,
      @required this.barcode,
      @required this.productName,
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
      this.photosUrl,
      this.sugar,
      this.animalProteins,
      this.plantProteins,
      this.saturated,
      this.unsaturated,
      this.omega3,
      this.omega6,
      this.fiber,
      this.caffeine,
      this.cholesterol,
      this.salt,
      this.vitaminA,
      this.vitaminC,
      this.vitaminD,
      this.vitaminE,
      this.vitaminK,
      this.vitaminB1,
      this.vitaminB2,
      this.vitaminB3,
      this.vitaminB5,
      this.vitaminB6,
      this.vitaminB7,
      this.vitaminB9,
      this.vitaminB12,
      this.potassium,
      this.sodium,
      this.calcium,
      this.magnesium,
      this.phosphorus,
      this.iron,
      this.copper,
      this.zinc,
      this.selenium,
      this.manganese,
      this.iodine,
      this.chromium});

  factory Product.fromFirestore(DocumentSnapshot document) {
    //
    //   return Product(
    //     productID: document.documentID,
    //     barcode: data['barcode'],
    //     productName: data['productName'],
    //     verification: data['verification'],
    //     categoryPrimary: data['categoryPrimary'],
    //     categorySecondary: data['categorySecondary'],
    //     localeBase: data['localeBase'],
    //     unit: data['unit'],
    //     keyWords: data['keyWords'],
    //     portions: data['portions'],
    //     calories: data['calories'],
    //     proteins: data['proteins'],
    //     carbs: data['carbs'],
    //     fats: data['fats'],
    //     photosUrl: data['photosUrl'],
    //     sugar: data['sugar'],
    //     animalProteins: data['animalProteins'],
    //     plantProteins: data['plantProteins'],
    //     saturated: data['saturated'],
    //     unsaturated: data['unsaturated'],
    //     omega3: data['omega3'],
    //     omega6: data['omega6'],
    //     fiber: data['fiber'],
    //     caffeine: data['caffeine'],
    //     cholesterol: data['cholesterol'],
    //     salt: data['salt'],
    //     vitaminA: data['vitaminA'],
    //     vitaminC: data['vitaminC'],
    //     vitaminD: data['vitaminD'],
    //     vitaminE: data['vitaminE'],
    //     vitaminK: data['vitaminK'],
    //     vitaminB1: data['vitaminB1'],
    //     vitaminB2: data['vitaminB2'],
    //     vitaminB3: data['vitaminB3'],
    //     vitaminB5: data['vitaminB5'],
    //     vitaminB6: data['vitaminB6'],
    //     vitaminB7: data['vitaminB7'],
    //     vitaminB9: data['vitaminB9'],
    //     vitaminB12: data['vitaminB12'],
    //     potassium: data['potassium'],
    //     sodium: data['sodium'],
    //     calcium: data['calcium'],
    //     magnesium: data['magnesium'],
    //     phosphorus: data['phosphorus'],
    //     iron: data['iron'],
    //     copper: data['copper'],
    //     zinc: data['zinc'],
    //     selenium: data['selenium'],
    //     manganese: data['manganese'],
    //     iodine: data['iodine'],
    //     chromium: data['chromium'],
    //   );
    // }
    //
    // factory Product.fromMap(Map map) {
    //   return Product(
    //     productID: map['productID'],
    //     barcode: map['barcode'],
    //     productName: map['productName'],
    //     verification: map['verification'],
    //     categoryPrimary: map['categoryPrimary'],
    //     categorySecondary: map['categorySecondary'],
    //     localeBase: map['localeBase'],
    //     unit: map['unit'],
    //     keyWords: map['keyWords'],
    //     portions: map['portions'],
    //     calories: map['calories'],
    //     proteins: map['proteins'],
    //     carbs: map['carbs'],
    //     fats: map['fats'],
    //     photosUrl: map['photosUrl'],
    //     sugar: map['sugar'],
    //     animalProteins: map['animalProteins'],
    //     plantProteins: map['plantProteins'],
    //     saturated: map['saturated'],
    //     unsaturated: map['unsaturated'],
    //     omega3: map['omega3'],
    //     omega6: map['omega6'],
    //     fiber: map['fiber'],
    //     caffeine: map['caffeine'],
    //     cholesterol: map['cholesterol'],
    //     salt: map['salt'],
    //     vitaminA: map['vitaminA'],
    //     vitaminC: map['vitaminC'],
    //     vitaminD: map['vitaminD'],
    //     vitaminE: map['vitaminE'],
    //     vitaminK: map['vitaminK'],
    //     vitaminB1: map['vitaminB1'],
    //     vitaminB2: map['vitaminB2'],
    //     vitaminB3: map['vitaminB3'],
    //     vitaminB5: map['vitaminB5'],
    //     vitaminB6: map['vitaminB6'],
    //     vitaminB7: map['vitaminB7'],
    //     vitaminB9: map['vitaminB9'],
    //     vitaminB12: map['vitaminB12'],
    //     potassium: map['potassium'],
    //     sodium: map['sodium'],
    //     calcium: map['calcium'],
    //     magnesium: map['magnesium'],
    //     phosphorus: map['phosphorus'],
    //     iron: map['iron'],
    //     copper: map['copper'],
    //     zinc: map['zinc'],
    //     selenium: map['selenium'],
    //     manganese: map['manganese'],
    //     iodine: map['iodine'],
    //     chromium: map['chromium'],
    //   );
    // }
    //
    // Map productToMap(Product product) {
    //   Map map = new Map();
    //
    //   map['productID'] = product.productID;
    //   map['barcode'] = product.barcode;
    //   map['productName'] = product.productName;
    //   map['verification'] = product.verification;
    //   map['categoryPrimary'] = product.categoryPrimary;
    //   map['categorySecondary'] = product.categorySecondary;
    //   map['localeBase'] = product.localeBase;
    //   map['unit'] = product.unit;
    //
    //   map['keyWords'] = product.keyWords;
    //   map['portions'] = product.portions;
    //
    //   map['calories'] = product.calories;
    //   map['proteins'] = product.proteins;
    //   map['carbs'] = product.carbs;
    //   map['fats'] = product.fats;
    //
    //   map['photosUrl'] = product.photosUrl;
    //   map['sugar'] = product.sugar;
    //   map['animalProteins'] = product.animalProteins;
    //   map['plantProteins'] = product.plantProteins;
    //   map['saturated'] = product.saturated;
    //   map['unsaturated'] = product.unsaturated;
    //   map['omega3'] = product.omega3;
    //   map['omega6'] = product.omega6;
    //   map['fiber'] = product.fiber;
    //   map['caffeine'] = product.caffeine;
    //   map['cholesterol'] = product.cholesterol;
    //   map['salt'] = product.salt;
    //   map['vitaminC'] = product.vitaminC;
    //   map['vitaminD'] = product.vitaminD;
    //   map['vitaminA'] = product.vitaminA;
    //   map['vitaminE'] = product.vitaminE;
    //   map['vitaminK'] = product.vitaminK;
    //   map['vitaminB1'] = product.vitaminB1;
    //   map['vitaminB2'] = product.vitaminB2;
    //   map['vitaminB3'] = product.vitaminB3;
    //   map['vitaminB5'] = product.vitaminB5;
    //   map['vitaminB6'] = product.vitaminB6;
    //   map['vitaminB7'] = product.vitaminB7;
    //   map['vitaminB9'] = product.vitaminB9;
    //   map['vitaminB12'] = product.vitaminB12;
    //   map['potassium'] = product.potassium;
    //   map['sodium'] = product.sodium;
    //   map['calcium'] = product.calcium;
    //   map['magnesium'] = product.magnesium;
    //   map['phosphorus'] = product.phosphorus;
    //   map['iron'] = product.iron;
    //   map['copper'] = product.copper;
    //   map['zinc'] = product.zinc;
    //   map['selenium'] = product.selenium;
    //   map['manganese'] = product.manganese;
    //   map['iodine'] = product.iodine;
    //   map['chromium'] = product.chromium;
    //
    //   return map;
  }
}
