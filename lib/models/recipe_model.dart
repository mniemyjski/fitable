import 'package:equatable/equatable.dart';
import 'package:fitable/models/ingredient_model.dart';
import 'package:fitable/models/portion_model.dart';
import 'package:flutter/material.dart';

class Recipe extends Equatable {
  const Recipe(
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

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

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

  Recipe copyWith({
    String uid,
    String access,
    String localeBase,
    String authorName,
    String id,
    String name,
    String description,
    Duration timePreparation,
    String videoUrl,
    List<String> keyWords,
    List<String> photosUrl,
    List<Ingredient> ingredients,
    List<Portion> portions,
    bool verification,
    double ratingsAvg,
    int ratingsCount,
    int favoritesCount,
    int commentsCount,
    DateTime dateCreation,
    DateTime dateLastUpdate,
  }) {
    if ((uid == null || identical(uid, this.uid)) &&
        (access == null || identical(access, this.access)) &&
        (localeBase == null || identical(localeBase, this.localeBase)) &&
        (authorName == null || identical(authorName, this.authorName)) &&
        (id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (description == null || identical(description, this.description)) &&
        (timePreparation == null || identical(timePreparation, this.timePreparation)) &&
        (videoUrl == null || identical(videoUrl, this.videoUrl)) &&
        (keyWords == null || identical(keyWords, this.keyWords)) &&
        (photosUrl == null || identical(photosUrl, this.photosUrl)) &&
        (ingredients == null || identical(ingredients, this.ingredients)) &&
        (portions == null || identical(portions, this.portions)) &&
        (verification == null || identical(verification, this.verification)) &&
        (ratingsAvg == null || identical(ratingsAvg, this.ratingsAvg)) &&
        (ratingsCount == null || identical(ratingsCount, this.ratingsCount)) &&
        (favoritesCount == null || identical(favoritesCount, this.favoritesCount)) &&
        (commentsCount == null || identical(commentsCount, this.commentsCount)) &&
        (dateCreation == null || identical(dateCreation, this.dateCreation)) &&
        (dateLastUpdate == null || identical(dateLastUpdate, this.dateLastUpdate))) {
      return this;
    }

    return new Recipe(
      uid: uid ?? this.uid,
      access: access ?? this.access,
      localeBase: localeBase ?? this.localeBase,
      authorName: authorName ?? this.authorName,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      timePreparation: timePreparation ?? this.timePreparation,
      videoUrl: videoUrl ?? this.videoUrl,
      keyWords: keyWords ?? this.keyWords,
      photosUrl: photosUrl ?? this.photosUrl,
      ingredients: ingredients ?? this.ingredients,
      portions: portions ?? this.portions,
      verification: verification ?? this.verification,
      ratingsAvg: ratingsAvg ?? this.ratingsAvg,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      dateCreation: dateCreation ?? this.dateCreation,
      dateLastUpdate: dateLastUpdate ?? this.dateLastUpdate,
    );
  }
}
