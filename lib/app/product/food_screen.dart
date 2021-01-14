import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/models/recipe_model.dart';
import 'package:fitable/app/product/view_model/food_view_model.dart';
import 'package:fitable/app/product/widget/nutritional.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class FoodScreenArguments {
  final MealType mealType;
  final Product product;
  final Meal meal;
  final Recipe recipe;

  FoodScreenArguments({@required this.mealType, this.product, this.meal, this.recipe});
}

_buildFloatingActionButton(BuildContext context) {
  final FoodScreenArguments args = ModalRoute.of(context).settings.arguments;
  final model = context.read(providerFoodViewModel);

  if (args.meal != null) {
    return FloatingActionButton(
      onPressed: () => model.submit(context: context, meal: args.meal, mealType: args.mealType),
      child: Icon(Icons.edit, color: Colors.white),
    );
  } else {
    return FloatingActionButton(
      onPressed: () => model.submit(context: context, product: args.product, mealType: args.mealType),
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}

class FoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final FoodScreenArguments args = ModalRoute.of(context).settings.arguments;
      final model = watch(providerFoodViewModel);
      model.build(args.product, args.recipe, args.meal);

      return CustomScaffold(
        appBar: AppBar(
          actions: [IconButton(icon: Icon(FontAwesomeIcons.heart), onPressed: () {})],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Container(
                  height: 55,
                  width: double.infinity,
                  child: Center(child: Text(model.name)),
                ),
              ),
              Card(
                  child: MacroAggregation(
                calories: model.calories,
                proteins: model.proteins,
                carbs: model.carbs,
                fats: model.fats,
                caloriesTarget: 2000,
                proteinsTarget: 180.0,
                carbsTarget: 200.0,
                fatsTarget: 60.0,
              )),
              Row(
                children: [
                  Container(
                    width: 150,
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      hintText: '100',
                      onChanged: (v) {
                        model.portionSize = double.tryParse(v);
                      },
                    ),
                  ),
                  Expanded(
                      child: CustomDropDownButton(
                          name: '',
                          value: model.portionChosen,
                          list: model.portions.keys.toList(),
                          onChanged: (v) {
                            model.portionChosen = v;
                          }))
                ],
              ),
              FlatButton(
                  onPressed: () => model.bugReport(),
                  child: Text(
                    'bug_report'.tr(),
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  )),
              nutritional(product: args.product, recipe: args.recipe, meal: args.meal)
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      );
    });
  }
}
