enum SortType { last, best, popular }
enum ConnStatus { loading, success, signInScreen, createAccount }
enum FavoriteScreen { onlyProducts, allFoods, workouts, accounts }
enum SearchType { recipes, products, accounts, workouts }
enum UnitType { kg, g, l, ml }
enum MacroType { size, calories, proteins, carbs, fats }
enum ElementType { product, recipe, account, comment }
enum IssueType { other, correct, regulations }

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
