// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'measurement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Measurement _$MeasurementFromJson(Map<String, dynamic> json) {
  return _Measurement.fromJson(json);
}

/// @nodoc
class _$MeasurementTearOff {
  const _$MeasurementTearOff();

  _Measurement call(
      {required String id,
      required String uid,
      required String source,
      required ETypeMeasurement dataType,
      required String unit,
      required DateTime dateTime,
      required DateTime dateCreation}) {
    return _Measurement(
      id: id,
      uid: uid,
      source: source,
      dataType: dataType,
      unit: unit,
      dateTime: dateTime,
      dateCreation: dateCreation,
    );
  }

  Measurement fromJson(Map<String, Object?> json) {
    return Measurement.fromJson(json);
  }
}

/// @nodoc
const $Measurement = _$MeasurementTearOff();

/// @nodoc
mixin _$Measurement {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  ETypeMeasurement get dataType => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  DateTime get dateCreation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeasurementCopyWith<Measurement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasurementCopyWith<$Res> {
  factory $MeasurementCopyWith(
          Measurement value, $Res Function(Measurement) then) =
      _$MeasurementCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String uid,
      String source,
      ETypeMeasurement dataType,
      String unit,
      DateTime dateTime,
      DateTime dateCreation});
}

/// @nodoc
class _$MeasurementCopyWithImpl<$Res> implements $MeasurementCopyWith<$Res> {
  _$MeasurementCopyWithImpl(this._value, this._then);

  final Measurement _value;
  // ignore: unused_field
  final $Res Function(Measurement) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? source = freezed,
    Object? dataType = freezed,
    Object? unit = freezed,
    Object? dateTime = freezed,
    Object? dateCreation = freezed,
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
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      dataType: dataType == freezed
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as ETypeMeasurement,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$MeasurementCopyWith<$Res>
    implements $MeasurementCopyWith<$Res> {
  factory _$MeasurementCopyWith(
          _Measurement value, $Res Function(_Measurement) then) =
      __$MeasurementCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String uid,
      String source,
      ETypeMeasurement dataType,
      String unit,
      DateTime dateTime,
      DateTime dateCreation});
}

/// @nodoc
class __$MeasurementCopyWithImpl<$Res> extends _$MeasurementCopyWithImpl<$Res>
    implements _$MeasurementCopyWith<$Res> {
  __$MeasurementCopyWithImpl(
      _Measurement _value, $Res Function(_Measurement) _then)
      : super(_value, (v) => _then(v as _Measurement));

  @override
  _Measurement get _value => super._value as _Measurement;

  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? source = freezed,
    Object? dataType = freezed,
    Object? unit = freezed,
    Object? dateTime = freezed,
    Object? dateCreation = freezed,
  }) {
    return _then(_Measurement(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      dataType: dataType == freezed
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as ETypeMeasurement,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Measurement implements _Measurement {
  const _$_Measurement(
      {required this.id,
      required this.uid,
      required this.source,
      required this.dataType,
      required this.unit,
      required this.dateTime,
      required this.dateCreation});

  factory _$_Measurement.fromJson(Map<String, dynamic> json) =>
      _$$_MeasurementFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final String source;
  @override
  final ETypeMeasurement dataType;
  @override
  final String unit;
  @override
  final DateTime dateTime;
  @override
  final DateTime dateCreation;

  @override
  String toString() {
    return 'Measurement(id: $id, uid: $uid, source: $source, dataType: $dataType, unit: $unit, dateTime: $dateTime, dateCreation: $dateCreation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Measurement &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality().equals(other.dataType, dataType) &&
            const DeepCollectionEquality().equals(other.unit, unit) &&
            const DeepCollectionEquality().equals(other.dateTime, dateTime) &&
            const DeepCollectionEquality()
                .equals(other.dateCreation, dateCreation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(source),
      const DeepCollectionEquality().hash(dataType),
      const DeepCollectionEquality().hash(unit),
      const DeepCollectionEquality().hash(dateTime),
      const DeepCollectionEquality().hash(dateCreation));

  @JsonKey(ignore: true)
  @override
  _$MeasurementCopyWith<_Measurement> get copyWith =>
      __$MeasurementCopyWithImpl<_Measurement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MeasurementToJson(this);
  }
}

abstract class _Measurement implements Measurement {
  const factory _Measurement(
      {required String id,
      required String uid,
      required String source,
      required ETypeMeasurement dataType,
      required String unit,
      required DateTime dateTime,
      required DateTime dateCreation}) = _$_Measurement;

  factory _Measurement.fromJson(Map<String, dynamic> json) =
      _$_Measurement.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  String get source;
  @override
  ETypeMeasurement get dataType;
  @override
  String get unit;
  @override
  DateTime get dateTime;
  @override
  DateTime get dateCreation;
  @override
  @JsonKey(ignore: true)
  _$MeasurementCopyWith<_Measurement> get copyWith =>
      throw _privateConstructorUsedError;
}
