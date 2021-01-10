import 'package:fitable/app/account/view_model/app_view_model.dart';
import 'package:fitable/app/home/widgets/chooser_date.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/home/widgets/tile_head_meals.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  double _calories = 0;
  double _proteins = 0;
  double _carbs = 0;
  double _fats = 0;
  double _caloriesTarget = 2000;
  double _proteinsTarget = 50;
  double _carbsTarget = 50;
  double _fatsTarget = 50;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(Constants.home.tr()),
      ),
      drawer: MainDrawer(),
      body: Consumer(
        builder: (context, watch, child) {
          final model = watch(providerAppModel);

          return Column(children: [
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    buildChooserDate(-1),
                    buildChooserDate(0),
                    buildChooserDate(1),
                  ],
                )),
            Expanded(
                child: ListView(
              children: [
                TileHeadMeals(mealType: MealType.breakfast),
                TileHeadMeals(mealType: MealType.lunch),
                TileHeadMeals(mealType: MealType.dinner),
                TileHeadMeals(mealType: MealType.supper),
                TileHeadMeals(mealType: MealType.snack),
              ],
            ))
          ]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: MacroAggregation(
          calories: _calories,
          proteins: _proteins,
          carbs: _carbs,
          fats: _fats,
          caloriesTarget: _caloriesTarget,
          proteinsTarget: _proteinsTarget,
          carbsTarget: _proteinsTarget,
          fatsTarget: _carbsTarget,
        ),
      ),
    );
  }
}
