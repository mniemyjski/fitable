import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum EnumMeasurement { BODY_WEIGHT, BODY_FAT, BODY_MUSCLE }

class Measurement {
  final String uid;
  final String source;
  final EnumMeasurement dataType;
  final double value;
  final String unit;
  final DocumentSnapshot document;
  final DateTime dateTime;
  final DateTime dateCreation;

  Measurement({
    @required this.uid,
    @required this.source,
    @required this.dataType,
    @required this.value,
    @required this.unit,
    @required this.document,
    @required this.dateTime,
    @required this.dateCreation,
  });

//   factory Measurement.fromFirestore(DocumentSnapshot document) {
//     Map data = document.data;
//
//     return Measurement(
//       uid: data['uid'],
//       source: data['source'],
//       dataType: _measurementToEnum(data['dataType']),
//       value: data['value'],
//       unit: data['unit'],
//       document: document,
//       dateTime: data['dateTime'].toDate(),
//       dateCreation: data['dateCreation'].toDate(),
//     );
//   }
// }
//
// measurementToString(EnumMeasurement enumMeasurement) {
//   switch (enumMeasurement) {
//     case EnumMeasurement.BODY_WEIGHT:
//       return 'BODY_WEIGHT';
//     case EnumMeasurement.BODY_FAT:
//       return 'BODY_FAT';
//     case EnumMeasurement.BODY_MUSCLE:
//       return 'BODY_MUSCLE';
//   }
// }
//
// _measurementToEnum(String enumMeasurement) {
//   switch (enumMeasurement) {
//     case 'BODY_WEIGHT':
//       return EnumMeasurement.BODY_WEIGHT;
//     case 'BODY_FAT':
//       return EnumMeasurement.BODY_FAT;
//     case 'BODY_MUSCLE':
//       return EnumMeasurement.BODY_MUSCLE;
//   }
}
