import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';

enum ETypeFavorite { products, recipes, exercise, trainings, accounts }

@freezed
class Favorite with _$Favorite {
  const factory Favorite({
    required String uid,
    required ETypeFavorite type,
    required String category,
    required String id,
    required DateTime dateCreation,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);
}
