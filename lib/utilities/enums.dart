import 'package:flutter/cupertino.dart';

enum TypeEnum {
  sortType,
  connStatus,
  favoriteScreen,
  searchType,
  unitType,
  macroType,
  elementType,
  issueType,
  mealType,
}

enum SortType { last, best, popular }
enum ConnStatus { loading, success, signInScreen, createAccount }
enum FavoriteScreen { onlyProducts, allFoods, workouts, accounts }
enum SearchType { recipes, products, accounts, workouts }
enum UnitType { kg, g, l, ml }
enum MacroType { size, calories, proteins, carbs, fats }
enum ElementType { product, recipe, account, comment }
enum IssueType { other, correct, regulations }
enum MealType { breakfast, lunch, dinner, supper, snack }

class Enums {
  static String toText(dynamic element) => element.toString().split('.').last;

  static toEnum({@required String value, @required TypeEnum typeEnum}) {
    switch (typeEnum) {
      case TypeEnum.sortType:
        // TODO: Handle this case.
        break;
      case TypeEnum.connStatus:
        // TODO: Handle this case.
        break;
      case TypeEnum.favoriteScreen:
        // TODO: Handle this case.
        break;
      case TypeEnum.searchType:
        // TODO: Handle this case.
        break;
      case TypeEnum.unitType:
        return _unitTypeToEnum(value);
        break;
      case TypeEnum.macroType:
        // TODO: Handle this case.
        break;
      case TypeEnum.elementType:
        // TODO: Handle this case.
        break;
      case TypeEnum.issueType:
        // TODO: Handle this case.
        break;
      case TypeEnum.mealType:
        return _mealTypeToEnum(value);
        break;
    }
  }

  static _unitTypeToEnum(String value) {
    switch (value) {
      case 'kg':
        return UnitType.kg;
      case 'g':
        return UnitType.g;
      case 'l':
        return UnitType.l;
      case 'ml':
        return UnitType.ml;
    }
  }

  static _mealTypeToEnum(String value) {
    switch (value) {
      case 'breakfast':
        return MealType.breakfast;
      case 'lunch':
        return MealType.lunch;
      case 'dinner':
        return MealType.dinner;
      case 'supper':
        return MealType.supper;
      case 'snack':
        return MealType.snack;
    }
  }
}
