import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

class Portion {
  final String name;
  final String type;
  final double size;
  final TypeUnit unit;

  Portion({this.name, @required this.type, @required this.size, @required this.unit});

  Map<String, dynamic> toMap() {
    return {
      'name': '$type: $size${Enums.toText(unit)}',
      'type': type,
      'size': size,
      'unit': Enums.toText(unit),
    };
  }

  factory Portion.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return Portion(
      name: data['name'],
      type: data['type'],
      size: data['size'],
      unit: Enums.toEnum(data['unit'], TypeUnit.values),
    );
  }

  static List convertPortionsToMapList(List portions) {
    List _portions = [];
    portions.forEach((element) {
      _portions.add(element.toMap());
    });
    return _portions;
  }

  static List<Portion> convertPortionsToModelList(List portions) {
    List<Portion> _portions = [];
    portions.forEach((element) {
      _portions.add(Portion.fromMap(element));
    });

    return _portions;
  }
}
