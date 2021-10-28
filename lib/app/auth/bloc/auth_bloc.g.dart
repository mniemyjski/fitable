// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Initial _$$InitialFromJson(Map<String, dynamic> json) => _$Initial(
      json['sessionId'] as String?,
    );

Map<String, dynamic> _$$InitialToJson(_$Initial instance) => <String, dynamic>{
      'sessionId': instance.sessionId,
    };

_$Authenticated _$$AuthenticatedFromJson(Map<String, dynamic> json) =>
    _$Authenticated(
      json['sessionId'] as String,
    );

Map<String, dynamic> _$$AuthenticatedToJson(_$Authenticated instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
    };

_$Unauthenticated _$$UnauthenticatedFromJson(Map<String, dynamic> json) =>
    _$Unauthenticated();

Map<String, dynamic> _$$UnauthenticatedToJson(_$Unauthenticated instance) =>
    <String, dynamic>{};
