import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum EnumFavorite { products, recipes, exercise, trainings, users }

final providerFavorite = StreamProvider<List<Favorite>>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamFavorites();
});

class Favorite {
  final String uid;
  final EnumFavorite type;
  final String category;
  final String id;
  final DateTime dateCreation;

  Favorite({
    this.uid,
    @required this.type,
    this.category = 'default',
    @required this.id,
    this.dateCreation,
  });

  Map<String, dynamic> toMap(String uid) {
    return {
      'uid': uid,
      'type': toText(type),
      'category': category,
      'id': id,
      'dateCreation': DateTime.now(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    return Favorite(
      uid: data['uid'],
      type: toEnum(data['type']),
      category: data['category'],
      id: data['id'],
      dateCreation: data['dateCreation'].toDate(),
    );
  }

  static toText(EnumFavorite favorite) {
    switch (favorite) {
      case EnumFavorite.products:
        return 'products';
      case EnumFavorite.recipes:
        return 'recipes';
      case EnumFavorite.exercise:
        return 'exercise';
      case EnumFavorite.trainings:
        return 'trainings';
      case EnumFavorite.users:
        return 'users';
    }
  }

  static toEnum(String favorite) {
    switch (favorite) {
      case 'products':
        return EnumFavorite.products;
      case 'recipes':
        return EnumFavorite.recipes;
      case 'exercise':
        return EnumFavorite.exercise;
      case 'trainings':
        return EnumFavorite.trainings;
      case 'users':
        return EnumFavorite.users;
    }
  }
}
