// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Measurement _$$_MeasurementFromJson(Map<String, dynamic> json) =>
    _$_Measurement(
      id: json['id'] as String,
      uid: json['uid'] as String,
      source: json['source'] as String,
      dataType: $enumDecode(_$ETypeMeasurementEnumMap, json['dataType']),
      unit: json['unit'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      dateCreation: DateTime.parse(json['dateCreation'] as String),
    );

Map<String, dynamic> _$$_MeasurementToJson(_$_Measurement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'source': instance.source,
      'dataType': _$ETypeMeasurementEnumMap[instance.dataType],
      'unit': instance.unit,
      'dateTime': instance.dateTime.toIso8601String(),
      'dateCreation': instance.dateCreation.toIso8601String(),
    };

const _$ETypeMeasurementEnumMap = {
  ETypeMeasurement.BODY_WEIGHT: 'BODY_WEIGHT',
  ETypeMeasurement.BODY_FAT: 'BODY_FAT',
  ETypeMeasurement.BODY_MUSCLE: 'BODY_MUSCLE',
  ETypeMeasurement.BODY_CIRCUMFERENCES: 'BODY_CIRCUMFERENCES',
  ETypeMeasurement.BURN_CALORIES: 'BURN_CALORIES',
  ETypeMeasurement.STEPS: 'STEPS',
};
