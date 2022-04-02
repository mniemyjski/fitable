// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Portion _$$_PortionFromJson(Map<String, dynamic> json) => _$_Portion(
      name: json['name'] as String,
      type: json['type'] as String,
      size: (json['size'] as num).toDouble(),
      unit: $enumDecode(_$ETypeUnitEnumMap, json['unit']),
    );

Map<String, dynamic> _$$_PortionToJson(_$_Portion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'size': instance.size,
      'unit': _$ETypeUnitEnumMap[instance.unit],
    };

const _$ETypeUnitEnumMap = {
  ETypeUnit.kg: 'kg',
  ETypeUnit.g: 'g',
  ETypeUnit.l: 'l',
  ETypeUnit.ml: 'ml',
};
