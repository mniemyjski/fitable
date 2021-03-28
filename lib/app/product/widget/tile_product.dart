import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/models/ingredient_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TileProduct extends StatelessWidget {
  final Product product;
  final Ingredient ingredient;
  final Meal meal;
  final Recipe recipe;

  const TileProduct({Key key, this.product, this.ingredient, this.meal, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _name;
    String _size;
    String _calories;
    String _proteins;
    String _carbs;
    String _fats;

    double _kcal = 0;
    double _p = 0;
    double _c = 0;
    double _f = 0;

    if (product != null) {
      _name = product.name;
      _size = '100${product.unit}';
      _calories = product.calories.toStringAsFixed(0);
      _proteins = product.proteins.toStringAsFixed(1);
      _carbs = product.carbs.toStringAsFixed(1);
      _fats = product.fats.toStringAsFixed(1);
    }
    if (ingredient != null) {
      _name = ingredient.product.name;
      _size = (ingredient.portionSize * ingredient.product.portions[ingredient.portionChosen]).toStringAsFixed(0) + ingredient.product.unit;
      _calories =
          (ingredient.product.calories * ingredient.portionSize * ingredient.product.portions[ingredient.portionChosen] / 100).toStringAsFixed(0);
      _proteins =
          (ingredient.product.proteins * ingredient.portionSize * ingredient.product.portions[ingredient.portionChosen] / 100).toStringAsFixed(1);
      _carbs = (ingredient.product.carbs * ingredient.portionSize * ingredient.product.portions[ingredient.portionChosen] / 100).toStringAsFixed(1);
      _fats = (ingredient.product.fats * ingredient.portionSize * ingredient.product.portions[ingredient.portionChosen] / 100).toStringAsFixed(1);
    }
    if (meal != null) {
      if (meal.product != null) {
        _name = meal.product.name;
        _size = (meal.portionSize * meal.product.portions[meal.portionChosen]).toStringAsFixed(0) + meal.product.unit;
        _calories = (meal.product.calories * meal.portionSize * meal.product.portions[meal.portionChosen] / 100).toStringAsFixed(0);
        _proteins = (meal.product.proteins * meal.portionSize * meal.product.portions[meal.portionChosen] / 100).toStringAsFixed(1);
        _carbs = (meal.product.carbs * meal.portionSize * meal.product.portions[meal.portionChosen] / 100).toStringAsFixed(1);
        _fats = (meal.product.fats * meal.portionSize * meal.product.portions[meal.portionChosen] / 100).toStringAsFixed(1);
      }
      if (meal.recipe != null) {
        _name = meal.recipe.name;
        _size = (meal.portionSize * meal.recipe.portions[meal.portionChosen]).toStringAsFixed(0) + meal.recipe.unit;
        meal.recipe.ingredients.forEach((element) {
          _kcal = (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100);
          _p = (element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100);
          _c = (element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100);
          _f = (element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100);
        });
        _calories = (_kcal * meal.portionSize * meal.recipe.portions[meal.portionChosen] / 100).toStringAsFixed(0);
        _proteins = (_p * meal.portionSize * meal.recipe.portions[meal.portionChosen] / 100).toStringAsFixed(1);
        _carbs = (_c * meal.portionSize * meal.recipe.portions[meal.portionChosen] / 100).toStringAsFixed(1);
        _fats = (_f * meal.portionSize * meal.recipe.portions[meal.portionChosen] / 100).toStringAsFixed(1);
      }
    }
    if (recipe != null) {
      _name = recipe.name;
      _size = '100${recipe.unit}';
      recipe.ingredients.forEach((element) {
        _kcal = (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100);
        _p = (element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100);
        _c = (element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100);
        _f = (element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100);
      });
      _calories = _kcal.toStringAsFixed(0);
      _proteins = _p.toStringAsFixed(1);
      _carbs = _c.toStringAsFixed(1);
      _fats = _f.toStringAsFixed(1);
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 0),
                        width: double.infinity,
                        child: Text(_name,
                            style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 0),
                          width: double.infinity,
                          child: Text(_size,
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic))),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text('kcal'.tr() + ': $_calories',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('p'.tr() + ': $_proteins g',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('c'.tr() + ': $_carbs g',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('f'.tr() + ': $_fats g',
                              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic)),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
