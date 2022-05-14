// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'portion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Portion _$PortionFromJson(Map<String, dynamic> json) {
  return _Portion.fromJson(json);
}

/// @nodoc
class _$PortionTearOff {
  const _$PortionTearOff();

  _Portion call(
      {required String name,
      required ETypePortion type,
      required double size,
      required ETypeUnit unit}) {
    return _Portion(
      name: name,
      type: type,
      size: size,
      unit: unit,
    );
  }

  Portion fromJson(Map<String, Object?> json) {
    return Portion.fromJson(json);
  }
}

/// @nodoc
const $Portion = _$PortionTearOff();

/// @nodoc
mixin _$Portion {
  String get name => throw _privateConstructorUsedError;
  ETypePortion get type => throw _privateConstructorUsedError;
  double get size => throw _privateConstructorUsedError;
  ETypeUnit get unit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PortionCopyWith<Portion> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortionCopyWith<$Res> {
  factory $PortionCopyWith(Portion value, $Res Function(Portion) then) =
      _$PortionCopyWithImpl<$Res>;
  $Res call({String name, ETypePortion type, double size, ETypeUnit unit});
}

/// @nodoc
class _$PortionCopyWithImpl<$Res> implements $PortionCopyWith<$Res> {
  _$PortionCopyWithImpl(this._value, this._then);

  final Portion _value;
  // ignore: unused_field
  final $Res Function(Portion) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? type = freezed,
    Object? size = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ETypePortion,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as ETypeUnit,
    ));
  }
}

/// @nodoc
abstract class _$PortionCopyWith<$Res> implements $PortionCopyWith<$Res> {
  factory _$PortionCopyWith(_Portion value, $Res Function(_Portion) then) =
      __$PortionCopyWithImpl<$Res>;
  @override
  $Res call({String name, ETypePortion type, double size, ETypeUnit unit});
}

/// @nodoc
class __$PortionCopyWithImpl<$Res> extends _$PortionCopyWithImpl<$Res>
    implements _$PortionCopyWith<$Res> {
  __$PortionCopyWithImpl(_Portion _value, $Res Function(_Portion) _then)
      : super(_value, (v) => _then(v as _Portion));

  @override
  _Portion get _value => super._value as _Portion;

  @override
  $Res call({
    Object? name = freezed,
    Object? type = freezed,
    Object? size = freezed,
    Object? unit = freezed,
  }) {
    return _then(_Portion(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ETypePortion,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as ETypeUnit,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Portion implements _Portion {
  const _$_Portion(
      {required this.name,
      required this.type,
      required this.size,
      required this.unit});

  factory _$_Portion.fromJson(Map<String, dynamic> json) =>
      _$$_PortionFromJson(json);

  @override
  final String name;
  @override
  final ETypePortion type;
  @override
  final double size;
  @override
  final ETypeUnit unit;

  @override
  String toString() {
    return 'Portion(name: $name, type: $type, size: $size, unit: $unit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Portion &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.size, size) &&
            const DeepCollectionEquality().equals(other.unit, unit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(unit));

  @JsonKey(ignore: true)
  @override
  _$PortionCopyWith<_Portion> get copyWith =>
      __$PortionCopyWithImpl<_Portion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PortionToJson(this);
  }
}

abstract class _Portion implements Portion {
  const factory _Portion(
      {required String name,
      required ETypePortion type,
      required double size,
      required ETypeUnit unit}) = _$_Portion;

  factory _Portion.fromJson(Map<String, dynamic> json) = _$_Portion.fromJson;

  @override
  String get name;
  @override
  ETypePortion get type;
  @override
  double get size;
  @override
  ETypeUnit get unit;
  @override
  @JsonKey(ignore: true)
  _$PortionCopyWith<_Portion> get copyWith =>
      throw _privateConstructorUsedError;
}
