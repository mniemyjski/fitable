// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Portion _$$_PortionFromJson(Map<String, dynamic> json) => _$_Portion(
      name: json['name'] as String,
      type: $enumDecode(_$ETypePortionEnumMap, json['type']),
      size: (json['size'] as num).toDouble(),
      unit: $enumDecode(_$ETypeUnitEnumMap, json['unit']),
    );

Map<String, dynamic> _$$_PortionToJson(_$_Portion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$ETypePortionEnumMap[instance.type],
      'size': instance.size,
      'unit': _$ETypeUnitEnumMap[instance.unit],
    };

const _$ETypePortionEnumMap = {
  ETypePortion.package: 'package',
  ETypePortion.glass: 'glass',
  ETypePortion.teaSpoon: 'teaSpoon',
  ETypePortion.tableSpoon: 'tableSpoon',
  ETypePortion.unit: 'unit',
};

const _$ETypeUnitEnumMap = {
  ETypeUnit.g: 'g',
  ETypeUnit.ml: 'ml',
  ETypeUnit.kg: 'kg',
  ETypeUnit.l: 'l',
};
