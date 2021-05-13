import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

class Recipe {
  final String uid;
  final String access;
  final String localeBase;
  final String authorName;
  final String id;
  final String name;
  final String description;
  final Duration timePreparation;
  final String videoUrl;
  final List<String> keyWords;
  final List<String> photosUrl;
  final List<Ingredient> ingredients;
  final List<Portion> portions;
  final bool verification;
  final double ratingsAvg;
  final int ratingsCount;
  final int favoritesCount;
  final int commentsCount;
  final DateTime dateCreation;
  final DateTime dateLastUpdate;

  Recipe(
      {this.uid,
      this.id,
      @required this.localeBase,
      @required this.authorName,
      @required this.name,
      @required this.keyWords,
      @required this.description,
      @required this.videoUrl,
      @required this.photosUrl,
      @required this.access,
      @required this.ingredients,
      @required this.portions,
      @required this.timePreparation,
      @required this.verification,
      this.ratingsAvg,
      this.ratingsCount,
      this.favoritesCount,
      this.commentsCount,
      this.dateCreation,
      this.dateLastUpdate});

  Map<String, dynamic> toMap({String uid, String id}) {
    // List _ingredients = [];
    // ingredients.forEach((element) {
    //   _ingredients.add(element.toMap());
    // });

    return {
      'uid': uid ?? this.uid,
      'localeBase': localeBase,
      'authorName': authorName,
      'name': name,
      'id': id ?? this.id,
      'keyWords': List.from(keyWords),
      'description': description,
      'videoUrl': videoUrl,
      'photosUrl': List.from(photosUrl),
      'access': access,
      'ingredients': Ingredient.toListMap(ingredients),
      'portions': Portion.convertPortionsToMapList(portions),
      'timePreparation': timePreparation.inMinutes,
      'verification': verification,
      'ratingsAvg': ratingsAvg ?? 0.0,
      'ratingsCount': ratingsCount ?? 0,
      'favoritesCount': favoritesCount ?? 0,
      'commentsCount': commentsCount ?? 0,
      'dateCreation': dateCreation == null ? DateTime.now() : dateCreation,
      'dateLastUpdate': dateLastUpdate == null ? DateTime.now() : dateLastUpdate,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    // List<Ingredient> ingredients = [];
    // data['ingredients'].forEach((element) {
    //   ingredients.add(Ingredient.fromMap(element));
    // });

    return Recipe(
      uid: data['uid'],
      localeBase: data['localeBase'],
      authorName: data['authorName'],
      name: data['name'],
      id: data['id'],
      keyWords: List.from(data['keyWords']),
      description: data['description'],
      videoUrl: data['videoUrl'],
      photosUrl: List.from(data['photosUrl']),
      access: data['access'],
      portions: Portion.convertPortionsToModelList(data['portions']),
      timePreparation: Duration(minutes: data['timePreparation']),
      verification: data['verification'],
      ratingsAvg: data['ratingsAvg'].toDouble(),
      ratingsCount: data['ratingsCount'],
      favoritesCount: data['favoritesCount'],
      commentsCount: data['commentsCount'],
      ingredients: Ingredient.toListIngredient(data['ingredients']),
      dateCreation: data['dateCreation'].toDate(),
      dateLastUpdate: data['dateLastUpdate'].toDate(),
    );
  }

  int getCalories(double portionSize, double selectedSize) {
    double value = 0;
    double _sizeTotal = 0;
    ingredients.forEach((element) {
      _sizeTotal += element.size / 100;
    });

    ingredients.forEach((Ingredient e) {
      value += (e.product.calories * e.size * e.selectedPortion.size / 100);
    });

    return (value * portionSize * selectedSize / _sizeTotal / 100).round();
  }

  double getProteins(double portionSize, double selectedSize) {
    double value = 0;
    double _sizeTotal = 0;
    ingredients.forEach((element) {
      _sizeTotal += element.size / 100;
    });

    ingredients.forEach((Ingredient e) {
      value += (e.product.proteins * e.size * e.selectedPortion.size / 100);
    });
    return (value * portionSize * selectedSize / _sizeTotal / 100);
  }

  double getCarbs(double portionSize, double selectedSize) {
    double value = 0;
    double _sizeTotal = 0;
    ingredients.forEach((element) {
      _sizeTotal += element.size / 100;
    });

    ingredients.forEach((Ingredient e) {
      value += (e.product.carbs * e.size * e.selectedPortion.size / 100);
    });
    return (value * portionSize * selectedSize / _sizeTotal / 100);
  }

  double getFats(double portionSize, double selectedSize) {
    double value = 0;
    double _sizeTotal = 0;
    ingredients.forEach((element) {
      _sizeTotal += element.size / 100;
    });
    ingredients.forEach((Ingredient e) {
      value += (e.product.fats * e.size * e.selectedPortion.size / 100);
    });
    return (value * portionSize * selectedSize / _sizeTotal / 100);
  }

  List getPortionsStrings() {
    List<String> list = [];
    portions.forEach((element) {
      list.add('${element.name}');
    });
    return list;
  }

  delete() {}
  add() {}
  update() {}
}
