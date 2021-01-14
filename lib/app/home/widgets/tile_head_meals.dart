import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/product/food_screen.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/widget/tile_product.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/common_widgets/add_button.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileHeadMeals extends StatelessWidget {
  final MealType mealType;

  const TileHeadMeals({Key key, @required this.mealType}) : super(key: key);

  _buildListView() {
    return Consumer(builder: (context, watch, child) {
      final meals = watch(providerMeals);

      return meals.when(
        data: (data) => _buildData(context: context, list: data.where((element) => element.mealType == mealType).toList()),
        loading: () => Center(
          child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      );
    });
  }

  _buildData({@required BuildContext context, @required List<Meal> list}) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
            margin: EdgeInsets.only(right: 75),
            child: Divider(
              height: 5,
              color: Colors.grey,
            )),
        itemCount: list.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, int index) {
          final key = list.elementAt(index).id;
          final Meal meal = list.elementAt(index);

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoute.foodScreen,
                  arguments: FoodScreenArguments(
                    meal: meal,
                    mealType: mealType,
                  ));
            },
            child: Dismissible(
                key: Key(key),
                onDismissed: (direction) {
                  final db = context.read(providerDatabase);
                  db.deleteMeal(meal);
                },
                direction: DismissDirection.startToEnd,
                background: Container(
                  height: double.infinity,
                  child: Container(
                      height: double.infinity,
                      alignment: Alignment.centerLeft,
                      color: Colors.red[600],
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      )),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 90),
                  child: TileProduct(meal: meal),
                )),
          );
        },
      ),
    );
  }

  _buildHeadSum() {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
              Text('kcal'.tr() + ':', style: TextStyle(fontSize: 12)),
              SizedBox(width: 2),
              Text('0', style: TextStyle(fontSize: 12)),
            ])),
        Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              Text('p'.tr() + ':', style: TextStyle(fontSize: 12)),
              SizedBox(width: 2),
              Text('0' + 'g', style: TextStyle(fontSize: 12)),
            ])),
        Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              Text('c'.tr() + ':', style: TextStyle(fontSize: 12)),
              SizedBox(width: 2),
              Text('0' + 'g', style: TextStyle(fontSize: 12)),
            ])),
        Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              Text('f'.tr() + ':', style: TextStyle(fontSize: 12)),
              SizedBox(width: 2),
              Text('0' + 'g', style: TextStyle(fontSize: 12)),
            ])),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
              tilePadding: EdgeInsets.only(left: 10),
              childrenPadding: EdgeInsets.only(left: 10),
              initiallyExpanded: true,
              title: Card(
                margin: EdgeInsets.only(bottom: 5, top: 3),
                child: Container(
                  height: 47,
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text(Meal.mealTypeString(mealType).tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                      SizedBox(height: 5),
                      _buildHeadSum()
                    ],
                  ),
                ),
              ),
              trailing: Container(
                height: double.infinity,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: AddButton(onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoute.searchScreen, arguments: SearchScreenArguments(typeSearch: SearchType.allFoods, mealType: mealType));
                }),
              ),
              children: <Widget>[_buildListView()])),
    ]);
  }
}
