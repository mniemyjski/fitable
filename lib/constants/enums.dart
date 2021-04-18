enum SortType { last, best, popular }
enum ConnStatus { loading, success, signInScreen, createAccount }
enum FavoriteScreen { onlyProducts, allFoods, workouts, accounts }
enum SearchType { recipes, products, accounts, workouts }
enum UnitType { g, ml }

class Enums {
  static String toText(dynamic element) => element.toString().split('.').last;

  static unitTypeToEnum(String element) {
    switch (element) {
      case 'g':
        return UnitType.g;
      case 'ml':
        return UnitType.ml;
    }
  }
}
