import 'package:logger/logger.dart';

enum ETypeSort { last, best, popular }
enum ETypeConnStatus { loading, success, signInScreen, createAccount }
enum ETypeSearch { recipes, products, accounts, workouts }
enum ETypeUnit { kg, g, l, ml }
enum ETypeMacro { size, calories, proteins, carbs, fats }
enum ETypeElement { product, recipe, account, comment }
enum ETypeIssue { other, correct, regulations }
enum ETypeMeal { breakfast, lunch, dinner, supper, snack }
enum ETypeFavoriteScreen { onlyProducts, allFoods, workouts, accounts }
enum ETypeFavorite { products, recipes, exercise, trainings, accounts }
enum ETypeMeasurement { BODY_WEIGHT, BODY_FAT, BODY_MUSCLE, BODY_CIRCUMFERENCES, BURN_CALORIES, STEPS }
enum ETypeAccess { private, coach, friends, public }

class Enums {
  static String toText(dynamic element) => element.toString().split('.').last;

  static toEnum(String value, List<dynamic> enumValues) {
    try {
      return enumValues.singleWhere((element) => toText(element) == value);
    } on StateError catch (_) {
      return null;
    }
  }
}
