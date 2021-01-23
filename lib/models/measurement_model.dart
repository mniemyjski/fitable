import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum EnumMeasurement { BODY_WEIGHT, BODY_FAT, BODY_MUSCLE, BODY_CIRCUMFERENCES }

final providerMeasurement = StreamProvider<List<Measurement>>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamMeasurement();
});

class Measurement {
  final String id;
  final String uid;
  final String source;
  final EnumMeasurement dataType;
  final Map<String, dynamic> value;
  final String unit;
  final DateTime dateTime;
  final DateTime dateCreation;

  Measurement({
    this.id,
    this.uid,
    @required this.source,
    @required this.dataType,
    @required this.value,
    @required this.unit,
    @required this.dateTime,
    @required this.dateCreation,
  });

  static String toText(EnumMeasurement measurement) {
    switch (measurement) {
      case EnumMeasurement.BODY_WEIGHT:
        return 'BODY_WEIGHT';
        break;
      case EnumMeasurement.BODY_FAT:
        return 'BODY_FAT';
        break;
      case EnumMeasurement.BODY_MUSCLE:
        return 'BODY_MUSCLE';
        break;
      case EnumMeasurement.BODY_CIRCUMFERENCES:
        return 'BODY_CIRCUMFERENCES';
        break;
      default:
        return '';
    }
  }

  Map<String, dynamic> toMap(String id, String uid) {
    return {
      'id': id,
      'uid': uid,
      'source': source,
      'dataType': toText(dataType),
      'value': value,
      'unit': unit,
      'dateTime': dateTime,
      'dateCreation': dateCreation,
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) {
      return null;
    }

    _toEnum(String enumMeasurement) {
      switch (enumMeasurement) {
        case 'BODY_WEIGHT':
          return EnumMeasurement.BODY_WEIGHT;
        case 'BODY_FAT':
          return EnumMeasurement.BODY_FAT;
        case 'BODY_MUSCLE':
          return EnumMeasurement.BODY_MUSCLE;
        case 'BODY_CIRCUMFERENCES':
          return EnumMeasurement.BODY_CIRCUMFERENCES;
          break;
      }
    }

    return Measurement(
      id: id,
      uid: data['uid'],
      source: data['source'],
      dataType: _toEnum(data['dataType']),
      value: data['value'],
      unit: data['unit'],
      dateTime: data['dateTime'].toDate(),
      dateCreation: data['dateCreation'].toDate(),
    );
  }
}
