import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../app/home/models/portions/portion_model.dart';

class DateTimeConverter implements JsonConverter<DateTime, int> {
  const DateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(int.parse(jsonEncode(json)));

  @override
  int toJson(DateTime data) => jsonDecode(data.millisecondsSinceEpoch.toString());
}

class PortionConverter implements JsonConverter<Portion, String> {
  const PortionConverter();

  @override
  Portion fromJson(String json) => Portion.fromJson(jsonDecode(json));

  @override
  String toJson(Portion data) => data.toJson().toString();
}
