import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Favorite {
  final String uid;
  final TypeFavorite type;
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
      'type': Enums.toText(type),
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
      type: Enums.toEnum(data['type'], TypeFavorite.values),
      category: data['category'],
      id: data['id'],
      dateCreation: data['dateCreation'].toDate(),
    );
  }
}
