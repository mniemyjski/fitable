// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Auth _$$_AuthFromJson(Map<String, dynamic> json) => _$_Auth(
      userId: json['userId'] as String,
      sessionId: json['sessionId'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_AuthToJson(_$_Auth instance) => <String, dynamic>{
      'userId': instance.userId,
      'sessionId': instance.sessionId,
      'email': instance.email,
    };
