import 'package:logger/logger.dart';

class Enums {
  static String toText(dynamic element) => element.toString().split('.').last;

  static toEnum(String value, List<dynamic> enumValues) {
    try {
      return enumValues.singleWhere((element) => toText(element) == value);
    } catch (e) {
      Logger().wtf('enum error!!!');
      return null;
    }
  }

  static toList(List<dynamic> enumValues) {
    try {
      return enumValues.map((e) => toText(e)).toList();
    } catch (e) {
      Logger().wtf('enum error!!!');
      return null;
    }
  }
}
