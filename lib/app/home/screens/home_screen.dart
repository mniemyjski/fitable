import 'package:fitable/app/home/widgets/date_chooser.dart';
import 'package:fitable/app/home/widgets/element_meal.dart';
import 'package:fitable/app/home/widgets/nutritional_value.dart';
import 'package:fitable/app/home/widgets/tile_expansion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(title: Strings.home()),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            DateChooser(),
            Expanded(
              child: ListView(
                children: [
                  TileExpansion(
                    head: _meals(name: Strings.breakfast(), kcal: 0, protein: 0, carbs: 0, fats: 0),
                    list: [
                      ElementMeal(),
                      ElementMeal(),
                      ElementMeal(),
                      ElementMeal(),
                    ],
                  ),
                  TileExpansion(
                    head: _meals(name: Strings.lunch(), kcal: 0, protein: 0, carbs: 0, fats: 0),
                    list: [],
                  ),
                  TileExpansion(
                    head: _meals(name: Strings.dinner(), kcal: 0, protein: 0, carbs: 0, fats: 0),
                    list: [],
                  ),
                  TileExpansion(
                    head: _meals(name: Strings.supper(), kcal: 0, protein: 0, carbs: 0, fats: 0),
                    list: [],
                  ),
                  TileExpansion(
                    head: _meals(name: Strings.snack(), kcal: 0, protein: 0, carbs: 0, fats: 0),
                    list: [],
                  ),
                  TileExpansion(
                    head: _buildWorkout(),
                    list: [],
                  ),
                  TileExpansion(
                    head: buildMeasurement(),
                    list: [],
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ],
        ),
        bottomSheet: NutritionalValue(),
      ),
    );
  }

  Builder buildMeasurement() => Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('Measurements', style: Theme.of(context).textTheme.bodyText1),
            ),
            Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.weight, color: Colors.grey.withOpacity(0.5), size: 20),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('0',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 8,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: CircularProgressIndicator(
                        value: 0,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        backgroundColor: Colors.grey[400],
                        strokeWidth: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.bacon, color: Colors.grey.withOpacity(0.5), size: 20),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('0',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 8,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: CircularProgressIndicator(
                        value: 0,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        backgroundColor: Colors.grey[400],
                        strokeWidth: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        );
      });

  Builder _buildWorkout() => Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('Activities', style: Theme.of(context).textTheme.bodyText1),
            ),
            Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.shoePrints,
                        color: Colors.grey.withOpacity(0.5), size: 20),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('0',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 8,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: CircularProgressIndicator(
                        value: 0,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        backgroundColor: Colors.grey[400],
                        strokeWidth: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.gripfire,
                        color: Colors.grey.withOpacity(0.5), size: 25),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('0',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                fontSize: 8,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: CircularProgressIndicator(
                        value: 0,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        backgroundColor: Colors.grey[400],
                        strokeWidth: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        );
      });

  Builder _meals({
    required String name,
    required int kcal,
    required double protein,
    required double carbs,
    required double fats,
  }) {
    return Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Text(name, style: Theme.of(context).textTheme.bodyText1),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                    Text('kcal:', style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(width: 2),
                    Text(kcal.toString(), style: Theme.of(context).textTheme.bodyText1),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('p:', style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(width: 2),
                    Text('${protein.toStringAsFixed(1)}g',
                        style: Theme.of(context).textTheme.bodyText1),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('c:', style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(width: 2),
                    Text('${carbs.toStringAsFixed(1)}g',
                        style: Theme.of(context).textTheme.bodyText1),
                  ])),
              Expanded(
                  flex: 1,
                  child: Row(children: <Widget>[
                    Text('f:', style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(width: 2),
                    Text('${fats.toStringAsFixed(1)}g',
                        style: Theme.of(context).textTheme.bodyText1),
                  ])),
            ],
          ),
        ],
      );
    });
  }
}
