import 'package:equatable/equatable.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

class Portion extends Equatable {
  const Portion({this.name, @required this.type, @required this.size, @required this.unit});

  final String name;
  final String type;
  final double size;
  final ETypeUnit unit;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  Map<String, dynamic> toMap() {
    return {
      'name': '$type: $size${Enums.toText(unit)}',
      'type': type,
      'size': size.roundToDouble(),
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
      size: data['size'].roundToDouble(),
      unit: Enums.toEnum(data['unit'], ETypeUnit.values),
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

  Portion copyWith({
    String name,
    String type,
    double size,
    ETypeUnit unit,
  }) {
    if ((name == null || identical(name, this.name)) &&
        (type == null || identical(type, this.type)) &&
        (size == null || identical(size, this.size)) &&
        (unit == null || identical(unit, this.unit))) {
      return this;
    }

    return new Portion(
      name: name ?? this.name,
      type: type ?? this.type,
      size: size ?? this.size,
      unit: unit ?? this.unit,
    );
  }
}
