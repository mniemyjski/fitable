import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/meal/models/portion_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/models/recipe_model.dart';
import 'package:fitable/constants/enums.dart';
import 'package:logger/logger.dart';

abstract class Macro {
  static String getName(dynamic element) {
    if (element.runtimeType == Product) {
      return element.name;
    }

    if (element.runtimeType == Recipe) {
      return element.name;
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product.name;
      }
      if (element.recipe != null) {
        return element.recipe.name;
      }
    }
    return '';
  }

  static Product getProduct(dynamic element) {
    if (element.runtimeType == Product) {
      return element;
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product;
      }
    }
    return null;
  }

  static String getUnit(dynamic element) {
    if (element.runtimeType == Product) {
      return Enums.toText(element.portions.first.unit);
    }

    if (element.runtimeType == Recipe) {
      return Enums.toText(element.portions.first.unit);
    }

    if (element.runtimeType == Ingredient) {
      return Enums.toText(element.selectedPortion.unit);
    }
    return '';
  }

  static String getPortionName(dynamic element) {
    if (element.runtimeType == Product) {
      return '${element.size * element.selectedPortion.siz}';
    }

    if (element.runtimeType == Ingredient) {
      return element.size * element.selectedPortion.size;
    }
    return '100';
  }

  static String getId(dynamic element) {
    if (element.runtimeType == Product) {
      return element.id;
    }

    if (element.runtimeType == Recipe) {
      return element.id;
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product.id;
      }
      if (element.recipe != null) {
        return element.recipe.id;
      }
    }
    return '';
  }

  static List<Portion> getPortions(dynamic element) {
    if (element.runtimeType == Product) {
      return element.portions;
    }

    if (element.runtimeType == Recipe) {
      return element.portions;
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product.portions;
      }
      if (element.recipe != null) {
        return element.recipe.ingredients.recipe.portions;
      }
    }
    return [];
  }

  static List<String> getPortionsStrings(dynamic element) {
    List<String> list = [];
    Macro.getPortions(element).forEach((element) {
      list.add('${element.name}');
    });

    return list;
  }

  static Portion getSelectedPortion(dynamic element) {
    if (element.runtimeType == Product) {
      return element.portions.first;
    }

    if (element.runtimeType == Recipe) {
      return element.portions.first;
    }

    if (element.runtimeType == Ingredient) {
      return element.selectedPortion;
    }
    return null;
  }

  static List getKeyWords(dynamic element) {
    if (element.runtimeType == Product) {
      return element.keyWords;
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product.keyWords;
      }
      if (element.recipe != null) {
        return element.recipe.ingredients.recipe.keyWords;
      }
    }
    return [];
  }

  static double getSize(dynamic element) {
    if (element.runtimeType == Product) return 100.0;
    if (element.runtimeType == Recipe) return 100.0;
    if (element.runtimeType == Ingredient) return element.size;

    return 0.0;
  }

  static int getCalories(dynamic element) {
    if (element.runtimeType == Product) {
      return element.calories.round();
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product.calories.round();
      }
      if (element.recipe != null) {
        double i = 0;

        element.recipe.ingredients.forEach((e) {
          i += e.product.calories;
        });
        return i.round();
      }
    }
    return 0;
  }

  static double getProteins(dynamic element) {
    if (element.runtimeType == Product) {
      return element.proteins.roundToDouble();
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product.proteins;
      }
      if (element.recipe != null) {
        double i = 0;

        element.recipe.ingredients.forEach((e) {
          i += e.product.proteins;
        });
        return i;
      }
    }
    return 0.0;
  }

  static double getCarbs(dynamic element) {
    if (element.runtimeType == Product) {
      return element.carbs.roundToDouble();
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product.carbs;
      }
      if (element.recipe != null) {
        double i = 0;

        element.recipe.ingredients.forEach((e) {
          i += e.product.carbs;
        });
        return i;
      }
    }
    return 0.0;
  }

  static double getFats(dynamic element) {
    if (element.runtimeType == Product) {
      return element.fats.roundToDouble();
    }

    if (element.runtimeType == Ingredient) {
      if (element.product != null) {
        return element.product.fats;
      }
      if (element.recipe != null) {
        double i = 0;

        element.recipe.ingredients.forEach((e) {
          i += e.product.fats;
        });
        return i;
      }
    }
    return 0.0;
  }

  static int calculateCalories(dynamic element, double size, Portion selectedPortion) {
    if (element.runtimeType == Ingredient) {
      if (element.recipe != null) {
        int value = 0;
        element.recipe.ingredients.forEach((Ingredient e) {
          value += (e.product.calories * e.size * e.selectedPortion.size / 100).round();
        });
        return value;
      }
    }
    return (getCalories(element) * size * selectedPortion.size / 100).round();
  }

  static double calculateProteins(dynamic element, double size, Portion selectedPortion) {
    if (element.runtimeType == Ingredient) {
      if (element.recipe != null) {
        double value = 0;
        element.recipe.ingredients.forEach((Ingredient e) {
          value += (e.product.proteins * e.size * e.selectedPortion.size / 100).round();
        });
        return value;
      }
    }

    return (getProteins(element) * size * selectedPortion.size / 100);
  }

  static double calculateCarbs(dynamic element, double size, Portion selectedPortion) {
    if (element.runtimeType == Ingredient) {
      if (element.recipe != null) {
        double value = 0;
        element.recipe.ingredients.forEach((Ingredient e) {
          value += (e.product.carbs * e.size * e.selectedPortion.size / 100).round();
        });
        return value;
      }
    }
    return (getCarbs(element) * size * selectedPortion.size / 100);
  }

  static double calculateFats(dynamic element, double size, Portion selectedPortion) {
    if (element.runtimeType == Ingredient) {
      if (element.recipe != null) {
        double value = 0;
        element.recipe.ingredients.forEach((Ingredient e) {
          value += (e.product.fats * e.size * e.selectedPortion.size / 100).round();
        });
        return value;
      }
    }
    return (getFats(element) * size * selectedPortion.size / 100);
  }
}
