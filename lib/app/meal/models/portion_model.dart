import 'package:fitable/constants/enums.dart';
import 'package:flutter/material.dart';

class Portion {
  final String name;
  final double size;
  final UnitType unit;

  Portion({@required this.name, @required this.size, @required this.unit});

  Map<String, dynamic> toMap(String id) {
    return {
      'name': name,
      'size': size,
      'unit': unit,
    };
  }

  factory Portion.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return Portion(
      name: data['name'],
      size: data['size'],
      unit: data['unit'],
    );
  }
}
