// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Initial _$$InitialFromJson(Map<String, dynamic> json) => _$Initial(
      json['auth'] == null
          ? null
          : Auth.fromJson(json['auth'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InitialToJson(_$Initial instance) => <String, dynamic>{
      'auth': instance.auth?.toJson(),
      'runtimeType': instance.$type,
    };

_$Authenticated _$$AuthenticatedFromJson(Map<String, dynamic> json) =>
    _$Authenticated(
      Auth.fromJson(json['auth'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AuthenticatedToJson(_$Authenticated instance) =>
    <String, dynamic>{
      'auth': instance.auth.toJson(),
      'runtimeType': instance.$type,
    };

_$Unauthenticated _$$UnauthenticatedFromJson(Map<String, dynamic> json) =>
    _$Unauthenticated(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnauthenticatedToJson(_$Unauthenticated instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
