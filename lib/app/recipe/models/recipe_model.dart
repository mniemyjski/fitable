import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:flutter/material.dart';

class Recipe {
  final String uid;
  final String access;
  final String localeBase;
  final String authorName;
  final String id;
  final String name;
  final String description;
  final int timePreparation;
  final String videoUrl;
  final List keyWords;
  final Map photosUrl;
  final List<Ingredient> ingredient;
  final String unit;
  final Map portions;
  final bool verification;
  final double ratingsAvg;
  final int favoritesCount;
  final int commentsCount;

  Recipe({
    @required this.uid,
    @required this.localeBase,
    @required this.authorName,
    @required this.name,
    @required this.id,
    @required this.keyWords,
    @required this.description,
    @required this.videoUrl,
    @required this.photosUrl,
    @required this.access,
    @required this.ingredient,
    @required this.portions,
    @required this.unit,
    @required this.timePreparation,
    @required this.verification,
    @required this.ratingsAvg,
    @required this.favoritesCount,
    @required this.commentsCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    return Recipe(
      uid: null,
      localeBase: null,
      authorName: null,
      name: null,
      id: null,
      keyWords: null,
      description: null,
      videoUrl: null,
      photosUrl: null,
      access: null,
      portions: null,
      unit: null,
      timePreparation: null,
      verification: null,
      ratingsAvg: null,
      favoritesCount: null,
      commentsCount: null,
      ingredient: [],
    );
  }
}
