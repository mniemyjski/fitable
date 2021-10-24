// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'favorite_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return _Favorite.fromJson(json);
}

/// @nodoc
class _$FavoriteTearOff {
  const _$FavoriteTearOff();

  _Favorite call(
      {required String uid,
      required ETypeFavorite type,
      required String category,
      required String id,
      required DateTime dateCreation}) {
    return _Favorite(
      uid: uid,
      type: type,
      category: category,
      id: id,
      dateCreation: dateCreation,
    );
  }

  Favorite fromJson(Map<String, Object?> json) {
    return Favorite.fromJson(json);
  }
}

/// @nodoc
const $Favorite = _$FavoriteTearOff();

/// @nodoc
mixin _$Favorite {
  String get uid => throw _privateConstructorUsedError;
  ETypeFavorite get type => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  DateTime get dateCreation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoriteCopyWith<Favorite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteCopyWith<$Res> {
  factory $FavoriteCopyWith(Favorite value, $Res Function(Favorite) then) =
      _$FavoriteCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      ETypeFavorite type,
      String category,
      String id,
      DateTime dateCreation});
}

/// @nodoc
class _$FavoriteCopyWithImpl<$Res> implements $FavoriteCopyWith<$Res> {
  _$FavoriteCopyWithImpl(this._value, this._then);

  final Favorite _value;
  // ignore: unused_field
  final $Res Function(Favorite) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? type = freezed,
    Object? category = freezed,
    Object? id = freezed,
    Object? dateCreation = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ETypeFavorite,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$FavoriteCopyWith<$Res> implements $FavoriteCopyWith<$Res> {
  factory _$FavoriteCopyWith(_Favorite value, $Res Function(_Favorite) then) =
      __$FavoriteCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      ETypeFavorite type,
      String category,
      String id,
      DateTime dateCreation});
}

/// @nodoc
class __$FavoriteCopyWithImpl<$Res> extends _$FavoriteCopyWithImpl<$Res>
    implements _$FavoriteCopyWith<$Res> {
  __$FavoriteCopyWithImpl(_Favorite _value, $Res Function(_Favorite) _then)
      : super(_value, (v) => _then(v as _Favorite));

  @override
  _Favorite get _value => super._value as _Favorite;

  @override
  $Res call({
    Object? uid = freezed,
    Object? type = freezed,
    Object? category = freezed,
    Object? id = freezed,
    Object? dateCreation = freezed,
  }) {
    return _then(_Favorite(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ETypeFavorite,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Favorite with DiagnosticableTreeMixin implements _Favorite {
  const _$_Favorite(
      {required this.uid,
      required this.type,
      required this.category,
      required this.id,
      required this.dateCreation});

  factory _$_Favorite.fromJson(Map<String, dynamic> json) =>
      _$$_FavoriteFromJson(json);

  @override
  final String uid;
  @override
  final ETypeFavorite type;
  @override
  final String category;
  @override
  final String id;
  @override
  final DateTime dateCreation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Favorite(uid: $uid, type: $type, category: $category, id: $id, dateCreation: $dateCreation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Favorite'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('dateCreation', dateCreation));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Favorite &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dateCreation, dateCreation) ||
                other.dateCreation == dateCreation));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, type, category, id, dateCreation);

  @JsonKey(ignore: true)
  @override
  _$FavoriteCopyWith<_Favorite> get copyWith =>
      __$FavoriteCopyWithImpl<_Favorite>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavoriteToJson(this);
  }
}

abstract class _Favorite implements Favorite {
  const factory _Favorite(
      {required String uid,
      required ETypeFavorite type,
      required String category,
      required String id,
      required DateTime dateCreation}) = _$_Favorite;

  factory _Favorite.fromJson(Map<String, dynamic> json) = _$_Favorite.fromJson;

  @override
  String get uid;
  @override
  ETypeFavorite get type;
  @override
  String get category;
  @override
  String get id;
  @override
  DateTime get dateCreation;
  @override
  @JsonKey(ignore: true)
  _$FavoriteCopyWith<_Favorite> get copyWith =>
      throw _privateConstructorUsedError;
}
