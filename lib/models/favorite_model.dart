import 'package:equatable/equatable.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Favorite extends Equatable {
  const Favorite({
    this.uid,
    @required this.type,
    this.category = 'default',
    @required this.id,
    this.dateCreation,
  });

  final String uid;
  final ETypeFavorite type;
  final String category;
  final String id;
  final DateTime dateCreation;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

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
      type: Enums.toEnum(data['type'], ETypeFavorite.values),
      category: data['category'],
      id: data['id'],
      dateCreation: data['dateCreation'].toDate(),
    );
  }

  Favorite copyWith({
    String uid,
    ETypeFavorite type,
    String category,
    String id,
    DateTime dateCreation,
  }) {
    if ((uid == null || identical(uid, this.uid)) &&
        (type == null || identical(type, this.type)) &&
        (category == null || identical(category, this.category)) &&
        (id == null || identical(id, this.id)) &&
        (dateCreation == null || identical(dateCreation, this.dateCreation))) {
      return this;
    }

    return new Favorite(
      uid: uid ?? this.uid,
      type: type ?? this.type,
      category: category ?? this.category,
      id: id ?? this.id,
      dateCreation: dateCreation ?? this.dateCreation,
    );
  }
}
