import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String uid,
    required String localeBase,
    required String authorName,
    required String name,
    required List<String> keyWords,
    required List<String> photosUrl,
    required String description,
    required String videoUrl,
    required String access,
    required List<String> ingredients,
    required List<String> portions,
    required int timePreparation,
    required bool verification,
    required double ratingsAvg,
    required int ratingsCount,
    required int favoritesCount,
    required int commentsCount,
    required DateTime dateCreation,
    required DateTime dateLastUpdate,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
