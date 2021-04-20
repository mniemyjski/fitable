enum SortType { last, best, popular }
enum ConnStatus { loading, success, signInScreen, createAccount }
enum FavoriteScreen { onlyProducts, allFoods, workouts, accounts }
enum SearchType { recipes, products, accounts, workouts }
enum UnitType { kg, g, l, ml }

class Enums {
  static String toText(dynamic element) => element.toString().split('.').last;

  static unitTypeToEnum(String element) {
    switch (element) {
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
}
