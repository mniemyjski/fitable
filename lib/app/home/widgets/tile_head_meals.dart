import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/models/meal_model.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';

class TileHeadMeals extends StatelessWidget {
  final MealType mealType;

  const TileHeadMeals({Key key, @required this.mealType}) : super(key: key);

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
              initiallyExpanded: true,
              title: Card(
                margin: EdgeInsets.only(bottom: 5),
                child: Container(
                  height: 41,
                  margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text(Meal.mealTypeString(mealType).tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                      Row(
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
                      ),
                    ],
                  ),
                ),
              ),
              trailing: Card(
                color: Colors.indigo,
                margin: EdgeInsets.only(top: 1, bottom: 5),
                child: Container(
                  height: double.infinity,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoute.search,
                          arguments: SearchScreenArguments(
                            typeSearch: SearchType.allFoods,
                            mealType: mealType,
                          ));
                    },
                  ),
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, right: 0),
                  child: Container(),
                )
              ])),
    ]);
  }
}
