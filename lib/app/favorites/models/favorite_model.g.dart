// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Favorite _$$_FavoriteFromJson(Map<String, dynamic> json) => _$_Favorite(
      uid: json['uid'] as String,
      type: $enumDecode(_$ETypeFavoriteEnumMap, json['type']),
      category: json['category'] as String,
      id: json['id'] as String,
      dateCreation: DateTime.parse(json['dateCreation'] as String),
    );

Map<String, dynamic> _$$_FavoriteToJson(_$_Favorite instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'type': _$ETypeFavoriteEnumMap[instance.type],
      'category': instance.category,
      'id': instance.id,
      'dateCreation': instance.dateCreation.toIso8601String(),
    };

const _$ETypeFavoriteEnumMap = {
  ETypeFavorite.products: 'products',
  ETypeFavorite.recipes: 'recipes',
  ETypeFavorite.exercise: 'exercise',
  ETypeFavorite.trainings: 'trainings',
  ETypeFavorite.accounts: 'accounts',
};
