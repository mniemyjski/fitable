enum TypeSort { last, best, popular }
enum TypeConnStatus { loading, success, signInScreen, createAccount }
enum TypeSearch { recipes, products, accounts, workouts }
enum TypeUnit { kg, g, l, ml }
enum TypeMacro { size, calories, proteins, carbs, fats }
enum TypeElement { product, recipe, account, comment }
enum TypeIssue { other, correct, regulations }
enum TypeMeal { breakfast, lunch, dinner, supper, snack }
enum TypeFavoriteScreen { onlyProducts, allFoods, workouts, accounts }
enum TypeFavorite { products, recipes, exercise, trainings, accounts }

class Enums {
  static String toText(dynamic element) => element.toString().split('.').last;

  static toEnum(String value, List<dynamic> enumValues) {
    try {
      return TypeSort.values.singleWhere((element) => toText(element) == value);
    } on StateError catch (_) {
      return null;
    }
  }

  // static _toEnum({@required String value, @required dynamic enumType}) {
  //   switch (enumType) {
  //     case TypeSort:
  //       //
  //       break;
  //     case TypeConnStatus:
  //       //
  //       break;
  //     case TypeFavoriteScreen:
  //       //
  //       break;
  //     case TypeSearch:
  //       //
  //       break;
  //     case TypeUnit:
  //       return _typeUnit(value);
  //       break;
  //     case TypeMacro:
  //       //
  //       break;
  //     case TypeElement:
  //       //
  //       break;
  //     case TypeIssue:
  //       //
  //       break;
  //     case TypeMeal:
  //       return _typeMeal(value);
  //       break;
  //     case TypeFavorite:
  //       return _typeFavorite(value);
  //       break;
  //   }
  // }
  //
  // static _typeFavorite(String favorite) {
  //   switch (favorite) {
  //     case 'products':
  //       return TypeFavorite.products;
  //     case 'recipes':
  //       return TypeFavorite.recipes;
  //     case 'exercise':
  //       return TypeFavorite.exercise;
  //     case 'trainings':
  //       return TypeFavorite.trainings;
  //     case 'accounts':
  //       return TypeFavorite.accounts;
  //   }
  // }
  //
  // static _typeUnit(String value) {
  //   switch (value) {
  //     case 'kg':
  //       return TypeUnit.kg;
  //     case 'g':
  //       return TypeUnit.g;
  //     case 'l':
  //       return TypeUnit.l;
  //     case 'ml':
  //       return TypeUnit.ml;
  //   }
  // }
  //
  // static _typeMeal(String value) {
  //   switch (value) {
  //     case 'breakfast':
  //       return TypeMeal.breakfast;
  //     case 'lunch':
  //       return TypeMeal.lunch;
  //     case 'dinner':
  //       return TypeMeal.dinner;
  //     case 'supper':
  //       return TypeMeal.supper;
  //     case 'snack':
  //       return TypeMeal.snack;
  //   }
  // }
}
