// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return _Recipe.fromJson(json);
}

/// @nodoc
class _$RecipeTearOff {
  const _$RecipeTearOff();

  _Recipe call(
      {required String uid,
      required String id,
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
      required DateTime dateLastUpdate}) {
    return _Recipe(
      uid: uid,
      id: id,
      localeBase: localeBase,
      authorName: authorName,
      name: name,
      keyWords: keyWords,
      photosUrl: photosUrl,
      description: description,
      videoUrl: videoUrl,
      access: access,
      ingredients: ingredients,
      portions: portions,
      timePreparation: timePreparation,
      verification: verification,
      ratingsAvg: ratingsAvg,
      ratingsCount: ratingsCount,
      favoritesCount: favoritesCount,
      commentsCount: commentsCount,
      dateCreation: dateCreation,
      dateLastUpdate: dateLastUpdate,
    );
  }

  Recipe fromJson(Map<String, Object?> json) {
    return Recipe.fromJson(json);
  }
}

/// @nodoc
const $Recipe = _$RecipeTearOff();

/// @nodoc
mixin _$Recipe {
  String get uid => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get localeBase => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get keyWords => throw _privateConstructorUsedError;
  List<String> get photosUrl => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  String get access => throw _privateConstructorUsedError;
  List<String> get ingredients => throw _privateConstructorUsedError;
  List<String> get portions => throw _privateConstructorUsedError;
  int get timePreparation => throw _privateConstructorUsedError;
  bool get verification => throw _privateConstructorUsedError;
  double get ratingsAvg => throw _privateConstructorUsedError;
  int get ratingsCount => throw _privateConstructorUsedError;
  int get favoritesCount => throw _privateConstructorUsedError;
  int get commentsCount => throw _privateConstructorUsedError;
  DateTime get dateCreation => throw _privateConstructorUsedError;
  DateTime get dateLastUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecipeCopyWith<Recipe> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeCopyWith<$Res> {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) then) =
      _$RecipeCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String id,
      String localeBase,
      String authorName,
      String name,
      List<String> keyWords,
      List<String> photosUrl,
      String description,
      String videoUrl,
      String access,
      List<String> ingredients,
      List<String> portions,
      int timePreparation,
      bool verification,
      double ratingsAvg,
      int ratingsCount,
      int favoritesCount,
      int commentsCount,
      DateTime dateCreation,
      DateTime dateLastUpdate});
}

/// @nodoc
class _$RecipeCopyWithImpl<$Res> implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._value, this._then);

  final Recipe _value;
  // ignore: unused_field
  final $Res Function(Recipe) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? id = freezed,
    Object? localeBase = freezed,
    Object? authorName = freezed,
    Object? name = freezed,
    Object? keyWords = freezed,
    Object? photosUrl = freezed,
    Object? description = freezed,
    Object? videoUrl = freezed,
    Object? access = freezed,
    Object? ingredients = freezed,
    Object? portions = freezed,
    Object? timePreparation = freezed,
    Object? verification = freezed,
    Object? ratingsAvg = freezed,
    Object? ratingsCount = freezed,
    Object? favoritesCount = freezed,
    Object? commentsCount = freezed,
    Object? dateCreation = freezed,
    Object? dateLastUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      localeBase: localeBase == freezed
          ? _value.localeBase
          : localeBase // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: authorName == freezed
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      keyWords: keyWords == freezed
          ? _value.keyWords
          : keyWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photosUrl: photosUrl == freezed
          ? _value.photosUrl
          : photosUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: videoUrl == freezed
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      access: access == freezed
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: ingredients == freezed
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      portions: portions == freezed
          ? _value.portions
          : portions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timePreparation: timePreparation == freezed
          ? _value.timePreparation
          : timePreparation // ignore: cast_nullable_to_non_nullable
              as int,
      verification: verification == freezed
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as bool,
      ratingsAvg: ratingsAvg == freezed
          ? _value.ratingsAvg
          : ratingsAvg // ignore: cast_nullable_to_non_nullable
              as double,
      ratingsCount: ratingsCount == freezed
          ? _value.ratingsCount
          : ratingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      favoritesCount: favoritesCount == freezed
          ? _value.favoritesCount
          : favoritesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: commentsCount == freezed
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateLastUpdate: dateLastUpdate == freezed
          ? _value.dateLastUpdate
          : dateLastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$RecipeCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$RecipeCopyWith(_Recipe value, $Res Function(_Recipe) then) =
      __$RecipeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String id,
      String localeBase,
      String authorName,
      String name,
      List<String> keyWords,
      List<String> photosUrl,
      String description,
      String videoUrl,
      String access,
      List<String> ingredients,
      List<String> portions,
      int timePreparation,
      bool verification,
      double ratingsAvg,
      int ratingsCount,
      int favoritesCount,
      int commentsCount,
      DateTime dateCreation,
      DateTime dateLastUpdate});
}

/// @nodoc
class __$RecipeCopyWithImpl<$Res> extends _$RecipeCopyWithImpl<$Res>
    implements _$RecipeCopyWith<$Res> {
  __$RecipeCopyWithImpl(_Recipe _value, $Res Function(_Recipe) _then)
      : super(_value, (v) => _then(v as _Recipe));

  @override
  _Recipe get _value => super._value as _Recipe;

  @override
  $Res call({
    Object? uid = freezed,
    Object? id = freezed,
    Object? localeBase = freezed,
    Object? authorName = freezed,
    Object? name = freezed,
    Object? keyWords = freezed,
    Object? photosUrl = freezed,
    Object? description = freezed,
    Object? videoUrl = freezed,
    Object? access = freezed,
    Object? ingredients = freezed,
    Object? portions = freezed,
    Object? timePreparation = freezed,
    Object? verification = freezed,
    Object? ratingsAvg = freezed,
    Object? ratingsCount = freezed,
    Object? favoritesCount = freezed,
    Object? commentsCount = freezed,
    Object? dateCreation = freezed,
    Object? dateLastUpdate = freezed,
  }) {
    return _then(_Recipe(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      localeBase: localeBase == freezed
          ? _value.localeBase
          : localeBase // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: authorName == freezed
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      keyWords: keyWords == freezed
          ? _value.keyWords
          : keyWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      photosUrl: photosUrl == freezed
          ? _value.photosUrl
          : photosUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: videoUrl == freezed
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      access: access == freezed
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: ingredients == freezed
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      portions: portions == freezed
          ? _value.portions
          : portions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timePreparation: timePreparation == freezed
          ? _value.timePreparation
          : timePreparation // ignore: cast_nullable_to_non_nullable
              as int,
      verification: verification == freezed
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as bool,
      ratingsAvg: ratingsAvg == freezed
          ? _value.ratingsAvg
          : ratingsAvg // ignore: cast_nullable_to_non_nullable
              as double,
      ratingsCount: ratingsCount == freezed
          ? _value.ratingsCount
          : ratingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      favoritesCount: favoritesCount == freezed
          ? _value.favoritesCount
          : favoritesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: commentsCount == freezed
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateLastUpdate: dateLastUpdate == freezed
          ? _value.dateLastUpdate
          : dateLastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Recipe implements _Recipe {
  const _$_Recipe(
      {required this.uid,
      required this.id,
      required this.localeBase,
      required this.authorName,
      required this.name,
      required this.keyWords,
      required this.photosUrl,
      required this.description,
      required this.videoUrl,
      required this.access,
      required this.ingredients,
      required this.portions,
      required this.timePreparation,
      required this.verification,
      required this.ratingsAvg,
      required this.ratingsCount,
      required this.favoritesCount,
      required this.commentsCount,
      required this.dateCreation,
      required this.dateLastUpdate});

  factory _$_Recipe.fromJson(Map<String, dynamic> json) =>
      _$$_RecipeFromJson(json);

  @override
  final String uid;
  @override
  final String id;
  @override
  final String localeBase;
  @override
  final String authorName;
  @override
  final String name;
  @override
  final List<String> keyWords;
  @override
  final List<String> photosUrl;
  @override
  final String description;
  @override
  final String videoUrl;
  @override
  final String access;
  @override
  final List<String> ingredients;
  @override
  final List<String> portions;
  @override
  final int timePreparation;
  @override
  final bool verification;
  @override
  final double ratingsAvg;
  @override
  final int ratingsCount;
  @override
  final int favoritesCount;
  @override
  final int commentsCount;
  @override
  final DateTime dateCreation;
  @override
  final DateTime dateLastUpdate;

  @override
  String toString() {
    return 'Recipe(uid: $uid, id: $id, localeBase: $localeBase, authorName: $authorName, name: $name, keyWords: $keyWords, photosUrl: $photosUrl, description: $description, videoUrl: $videoUrl, access: $access, ingredients: $ingredients, portions: $portions, timePreparation: $timePreparation, verification: $verification, ratingsAvg: $ratingsAvg, ratingsCount: $ratingsCount, favoritesCount: $favoritesCount, commentsCount: $commentsCount, dateCreation: $dateCreation, dateLastUpdate: $dateLastUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Recipe &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.localeBase, localeBase) &&
            const DeepCollectionEquality()
                .equals(other.authorName, authorName) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.keyWords, keyWords) &&
            const DeepCollectionEquality().equals(other.photosUrl, photosUrl) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.videoUrl, videoUrl) &&
            const DeepCollectionEquality().equals(other.access, access) &&
            const DeepCollectionEquality()
                .equals(other.ingredients, ingredients) &&
            const DeepCollectionEquality().equals(other.portions, portions) &&
            const DeepCollectionEquality()
                .equals(other.timePreparation, timePreparation) &&
            const DeepCollectionEquality()
                .equals(other.verification, verification) &&
            const DeepCollectionEquality()
                .equals(other.ratingsAvg, ratingsAvg) &&
            const DeepCollectionEquality()
                .equals(other.ratingsCount, ratingsCount) &&
            const DeepCollectionEquality()
                .equals(other.favoritesCount, favoritesCount) &&
            const DeepCollectionEquality()
                .equals(other.commentsCount, commentsCount) &&
            const DeepCollectionEquality()
                .equals(other.dateCreation, dateCreation) &&
            const DeepCollectionEquality()
                .equals(other.dateLastUpdate, dateLastUpdate));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(uid),
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(localeBase),
        const DeepCollectionEquality().hash(authorName),
        const DeepCollectionEquality().hash(name),
        const DeepCollectionEquality().hash(keyWords),
        const DeepCollectionEquality().hash(photosUrl),
        const DeepCollectionEquality().hash(description),
        const DeepCollectionEquality().hash(videoUrl),
        const DeepCollectionEquality().hash(access),
        const DeepCollectionEquality().hash(ingredients),
        const DeepCollectionEquality().hash(portions),
        const DeepCollectionEquality().hash(timePreparation),
        const DeepCollectionEquality().hash(verification),
        const DeepCollectionEquality().hash(ratingsAvg),
        const DeepCollectionEquality().hash(ratingsCount),
        const DeepCollectionEquality().hash(favoritesCount),
        const DeepCollectionEquality().hash(commentsCount),
        const DeepCollectionEquality().hash(dateCreation),
        const DeepCollectionEquality().hash(dateLastUpdate)
      ]);

  @JsonKey(ignore: true)
  @override
  _$RecipeCopyWith<_Recipe> get copyWith =>
      __$RecipeCopyWithImpl<_Recipe>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecipeToJson(this);
  }
}

abstract class _Recipe implements Recipe {
  const factory _Recipe(
      {required String uid,
      required String id,
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
      required DateTime dateLastUpdate}) = _$_Recipe;

  factory _Recipe.fromJson(Map<String, dynamic> json) = _$_Recipe.fromJson;

  @override
  String get uid;
  @override
  String get id;
  @override
  String get localeBase;
  @override
  String get authorName;
  @override
  String get name;
  @override
  List<String> get keyWords;
  @override
  List<String> get photosUrl;
  @override
  String get description;
  @override
  String get videoUrl;
  @override
  String get access;
  @override
  List<String> get ingredients;
  @override
  List<String> get portions;
  @override
  int get timePreparation;
  @override
  bool get verification;
  @override
  double get ratingsAvg;
  @override
  int get ratingsCount;
  @override
  int get favoritesCount;
  @override
  int get commentsCount;
  @override
  DateTime get dateCreation;
  @override
  DateTime get dateLastUpdate;
  @override
  @JsonKey(ignore: true)
  _$RecipeCopyWith<_Recipe> get copyWith => throw _privateConstructorUsedError;
}
