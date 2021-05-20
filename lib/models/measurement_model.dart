import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Measurement {
  const Measurement({
    this.id,
    this.uid,
    @required this.source,
    @required this.dataType,
    @required this.data,
    @required this.unit,
    @required this.dateTime,
    @required this.dateCreation,
  });

  final String id;
  final String uid;
  final String source;
  final ETypeMeasurement dataType;
  final Map<String, dynamic> data;
  final String unit;
  final DateTime dateTime;
  final DateTime dateCreation;

  Map<String, dynamic> toMap(String id, String uid) {
    return {
      'id': id,
      'uid': uid,
      'source': source,
      'dataType': Enums.toText(dataType),
      'data': data,
      'unit': unit,
      'dateTime': dateTime,
      'dateCreation': dateCreation,
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) {
      return null;
    }

    return Measurement(
      id: id,
      uid: data['uid'],
      source: data['source'],
      dataType: Enums.toEnum(data['dataType'], ETypeMeasurement.values),
      data: data['data'],
      unit: data['unit'],
      dateTime: data['dateTime'].toDate(),
      dateCreation: data['dateCreation'].toDate(),
    );
  }

  Measurement copyWith({
    String id,
    String uid,
    String source,
    ETypeMeasurement dataType,
    Map<String, dynamic> data,
    String unit,
    DateTime dateTime,
    DateTime dateCreation,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (uid == null || identical(uid, this.uid)) &&
        (source == null || identical(source, this.source)) &&
        (dataType == null || identical(dataType, this.dataType)) &&
        (data == null || identical(data, this.data)) &&
        (unit == null || identical(unit, this.unit)) &&
        (dateTime == null || identical(dateTime, this.dateTime)) &&
        (dateCreation == null || identical(dateCreation, this.dateCreation))) {
      return this;
    }

    return new Measurement(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      source: source ?? this.source,
      dataType: dataType ?? this.dataType,
      data: data ?? this.data,
      unit: unit ?? this.unit,
      dateTime: dateTime ?? this.dateTime,
      dateCreation: dateCreation ?? this.dateCreation,
    );
  }
}
