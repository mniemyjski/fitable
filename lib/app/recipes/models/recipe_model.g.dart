// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Recipe _$$_RecipeFromJson(Map<String, dynamic> json) => _$_Recipe(
      uid: json['uid'] as String,
      id: json['id'] as String,
      localeBase: json['localeBase'] as String,
      authorName: json['authorName'] as String,
      name: json['name'] as String,
      keyWords:
          (json['keyWords'] as List<dynamic>).map((e) => e as String).toList(),
      photosUrl:
          (json['photosUrl'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      videoUrl: json['videoUrl'] as String,
      access: json['access'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      portions:
          (json['portions'] as List<dynamic>).map((e) => e as String).toList(),
      timePreparation: json['timePreparation'] as int,
      verification: json['verification'] as bool,
      ratingsAvg: (json['ratingsAvg'] as num).toDouble(),
      ratingsCount: json['ratingsCount'] as int,
      favoritesCount: json['favoritesCount'] as int,
      commentsCount: json['commentsCount'] as int,
      dateCreation: DateTime.parse(json['dateCreation'] as String),
      dateLastUpdate: DateTime.parse(json['dateLastUpdate'] as String),
    );

Map<String, dynamic> _$$_RecipeToJson(_$_Recipe instance) => <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'localeBase': instance.localeBase,
      'authorName': instance.authorName,
      'name': instance.name,
      'keyWords': instance.keyWords,
      'photosUrl': instance.photosUrl,
      'description': instance.description,
      'videoUrl': instance.videoUrl,
      'access': instance.access,
      'ingredients': instance.ingredients,
      'portions': instance.portions,
      'timePreparation': instance.timePreparation,
      'verification': instance.verification,
      'ratingsAvg': instance.ratingsAvg,
      'ratingsCount': instance.ratingsCount,
      'favoritesCount': instance.favoritesCount,
      'commentsCount': instance.commentsCount,
      'dateCreation': instance.dateCreation.toIso8601String(),
      'dateLastUpdate': instance.dateLastUpdate.toIso8601String(),
    };
