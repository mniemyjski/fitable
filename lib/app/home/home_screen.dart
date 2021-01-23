import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/app/home/widgets/chooser_date.dart';
import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/home/widgets/tile_head_meals.dart';
import 'package:fitable/app/home/widgets/tile_head_measurement.dart';
import 'package:fitable/app/home/widgets/tile_head_workouts.dart';
import 'package:fitable/common_widgets/monetize_ad.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  _buildBottomAppBar() {
    return BottomAppBar(
      child: Consumer(builder: (context, watch, child) {
        final meals = watch(providerMeals);
        final model = watch(providerHomeViewModel);
        final app = watch(providerAppViewModel);

        return meals.when(
          data: (data) {
            model.mealList = data.where((element) => element.dateTime == app.chosenDate).toList();
            return MacroAggregation();
          },
          loading: () => Center(
            child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
          ),
          error: (err, stack) => Center(child: Text('Error: $err')),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(Constants.home.tr()),
      ),
      drawer: MainDrawer(),
      body: Column(children: [
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
                chooserDate(-1),
                chooserDate(0),
                chooserDate(1),
              ],
            )),
        Expanded(
            child: ListView(
          children: [
            MonetizeAd(),
            TileHeadMeals(mealType: MealType.breakfast),
            TileHeadMeals(mealType: MealType.lunch),
            TileHeadMeals(mealType: MealType.dinner),
            TileHeadMeals(mealType: MealType.supper),
            TileHeadMeals(mealType: MealType.snack),
            TileHeadWorkouts(),
            TileHeadMeasurement(),
            SizedBox(height: 40)
          ],
        ))
      ]),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }
}
