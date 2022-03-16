// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_account_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Initial _$$InitialFromJson(Map<String, dynamic> json) => _$Initial(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InitialToJson(_$Initial instance) => <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$UnCreated _$$UnCreatedFromJson(Map<String, dynamic> json) => _$UnCreated(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnCreatedToJson(_$UnCreated instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$Created _$$CreatedFromJson(Map<String, dynamic> json) => _$Created(
      Account.fromJson(json['account'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CreatedToJson(_$Created instance) => <String, dynamic>{
      'account': instance.account.toJson(),
      'runtimeType': instance.$type,
    };
