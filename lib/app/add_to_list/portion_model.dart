import 'package:fitable/constants/enums.dart';
import 'package:flutter/material.dart';

class Portion {
  final String name;
  final int size;
  final UnitType unit;

  Portion({@required this.name, @required this.size, @required this.unit});
}
