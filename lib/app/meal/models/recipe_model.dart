import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/meal/models/ingredient_model.dart';
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
  final List keyWords;
  final List photosUrl;
  final List<Ingredient> ingredients;
  final String unit;
  final Map portions;
  final bool verification;
  final double ratingsAvg;
  final int ratingsCount;
  final int favoritesCount;
  final int commentsCount;
  final DateTime dateCreation;

  Recipe(
      {this.uid,
      @required this.localeBase,
      @required this.authorName,
      @required this.name,
      this.id,
      @required this.keyWords,
      @required this.description,
      @required this.videoUrl,
      @required this.photosUrl,
      @required this.access,
      @required this.ingredients,
      @required this.portions,
      @required this.unit,
      @required this.timePreparation,
      @required this.verification,
      this.ratingsAvg,
      this.ratingsCount,
      this.favoritesCount,
      this.commentsCount,
      this.dateCreation});

  Map<String, dynamic> toMap({String uid, String id}) {
    List _ingredients = [];
    ingredients.forEach((element) {
      _ingredients.add(element.toMap());
    });

    return {
      'uid': uid ?? this.uid,
      'localeBase': localeBase,
      'authorName': authorName,
      'name': name,
      'id': id ?? this.id,
      'keyWords': keyWords,
      'description': description,
      'videoUrl': videoUrl,
      'photosUrl': photosUrl,
      'access': access,
      'ingredient': _ingredients,
      'portions': portions,
      'unit': unit,
      'timePreparation': timePreparation.inMinutes,
      'verification': verification,
      'ratingsAvg': ratingsAvg ?? 0.0,
      'ratingsCount': ratingsCount ?? 0,
      'favoritesCount': favoritesCount ?? 0,
      'commentsCount': commentsCount ?? 0,
      'dateCreation': DateTime.now(),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    List<Ingredient> ingredients = [];
    data['ingredient'].forEach((element) {
      ingredients.add(Ingredient.fromMap(element));
    });

    return Recipe(
      uid: data['uid'],
      localeBase: data['localeBase'],
      authorName: data['authorName'],
      name: data['name'],
      id: data['id'],
      keyWords: data['keyWords'],
      description: data['description'],
      videoUrl: data['videoUrl'],
      photosUrl: data['photosUrl'],
      access: data['access'],
      portions: data['portions'],
      unit: data['unit'],
      timePreparation: Duration(minutes: data['timePreparation']),
      verification: data['verification'],
      ratingsAvg: data['ratingsAvg'].toDouble(),
      ratingsCount: data['ratingsCount'],
      favoritesCount: data['favoritesCount'],
      commentsCount: data['commentsCount'],
      ingredients: ingredients,
      dateCreation: data['dateCreation'].toDate(),
    );
  }
}
