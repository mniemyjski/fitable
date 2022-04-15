// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'meal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Meal _$MealFromJson(Map<String, dynamic> json) {
  return _Meal.fromJson(json);
}

/// @nodoc
class _$MealTearOff {
  const _$MealTearOff();

  _Meal call(
      {required String id,
      required String uid,
      required DateTime dateTime,
      required DateTime dateCreation,
      required ETypeMeal mealType,
      required Ingredient ingredient,
      required bool isSuggested}) {
    return _Meal(
      id: id,
      uid: uid,
      dateTime: dateTime,
      dateCreation: dateCreation,
      mealType: mealType,
      ingredient: ingredient,
      isSuggested: isSuggested,
    );
  }

  Meal fromJson(Map<String, Object?> json) {
    return Meal.fromJson(json);
  }
}

/// @nodoc
const $Meal = _$MealTearOff();

/// @nodoc
mixin _$Meal {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  DateTime get dateCreation => throw _privateConstructorUsedError;
  ETypeMeal get mealType => throw _privateConstructorUsedError;
  Ingredient get ingredient => throw _privateConstructorUsedError;
  bool get isSuggested => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MealCopyWith<Meal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealCopyWith<$Res> {
  factory $MealCopyWith(Meal value, $Res Function(Meal) then) =
      _$MealCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String uid,
      DateTime dateTime,
      DateTime dateCreation,
      ETypeMeal mealType,
      Ingredient ingredient,
      bool isSuggested});

  $IngredientCopyWith<$Res> get ingredient;
}

/// @nodoc
class _$MealCopyWithImpl<$Res> implements $MealCopyWith<$Res> {
  _$MealCopyWithImpl(this._value, this._then);

  final Meal _value;
  // ignore: unused_field
  final $Res Function(Meal) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? dateTime = freezed,
    Object? dateCreation = freezed,
    Object? mealType = freezed,
    Object? ingredient = freezed,
    Object? isSuggested = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: mealType == freezed
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as ETypeMeal,
      ingredient: ingredient == freezed
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as Ingredient,
      isSuggested: isSuggested == freezed
          ? _value.isSuggested
          : isSuggested // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $IngredientCopyWith<$Res> get ingredient {
    return $IngredientCopyWith<$Res>(_value.ingredient, (value) {
      return _then(_value.copyWith(ingredient: value));
    });
  }
}

/// @nodoc
abstract class _$MealCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$MealCopyWith(_Meal value, $Res Function(_Meal) then) =
      __$MealCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String uid,
      DateTime dateTime,
      DateTime dateCreation,
      ETypeMeal mealType,
      Ingredient ingredient,
      bool isSuggested});

  @override
  $IngredientCopyWith<$Res> get ingredient;
}

/// @nodoc
class __$MealCopyWithImpl<$Res> extends _$MealCopyWithImpl<$Res>
    implements _$MealCopyWith<$Res> {
  __$MealCopyWithImpl(_Meal _value, $Res Function(_Meal) _then)
      : super(_value, (v) => _then(v as _Meal));

  @override
  _Meal get _value => super._value as _Meal;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? dateTime = freezed,
    Object? dateCreation = freezed,
    Object? mealType = freezed,
    Object? ingredient = freezed,
    Object? isSuggested = freezed,
  }) {
    return _then(_Meal(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: mealType == freezed
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as ETypeMeal,
      ingredient: ingredient == freezed
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as Ingredient,
      isSuggested: isSuggested == freezed
          ? _value.isSuggested
          : isSuggested // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Meal implements _Meal {
  const _$_Meal(
      {required this.id,
      required this.uid,
      required this.dateTime,
      required this.dateCreation,
      required this.mealType,
      required this.ingredient,
      required this.isSuggested});

  factory _$_Meal.fromJson(Map<String, dynamic> json) => _$$_MealFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final DateTime dateTime;
  @override
  final DateTime dateCreation;
  @override
  final ETypeMeal mealType;
  @override
  final Ingredient ingredient;
  @override
  final bool isSuggested;

  @override
  String toString() {
    return 'Meal(id: $id, uid: $uid, dateTime: $dateTime, dateCreation: $dateCreation, mealType: $mealType, ingredient: $ingredient, isSuggested: $isSuggested)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Meal &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.dateTime, dateTime) &&
            const DeepCollectionEquality()
                .equals(other.dateCreation, dateCreation) &&
            const DeepCollectionEquality().equals(other.mealType, mealType) &&
            const DeepCollectionEquality()
                .equals(other.ingredient, ingredient) &&
            const DeepCollectionEquality()
                .equals(other.isSuggested, isSuggested));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(dateTime),
      const DeepCollectionEquality().hash(dateCreation),
      const DeepCollectionEquality().hash(mealType),
      const DeepCollectionEquality().hash(ingredient),
      const DeepCollectionEquality().hash(isSuggested));

  @JsonKey(ignore: true)
  @override
  _$MealCopyWith<_Meal> get copyWith =>
      __$MealCopyWithImpl<_Meal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MealToJson(this);
  }
}

abstract class _Meal implements Meal {
  const factory _Meal(
      {required String id,
      required String uid,
      required DateTime dateTime,
      required DateTime dateCreation,
      required ETypeMeal mealType,
      required Ingredient ingredient,
      required bool isSuggested}) = _$_Meal;

  factory _Meal.fromJson(Map<String, dynamic> json) = _$_Meal.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  DateTime get dateTime;
  @override
  DateTime get dateCreation;
  @override
  ETypeMeal get mealType;
  @override
  Ingredient get ingredient;
  @override
  bool get isSuggested;
  @override
  @JsonKey(ignore: true)
  _$MealCopyWith<_Meal> get copyWith => throw _privateConstructorUsedError;
}
