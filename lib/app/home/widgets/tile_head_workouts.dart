import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/widgets/tile_expansion.dart';
import 'package:fitable/app/measurement/models/measurement_model.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitable/utilities/providers.dart';

class TileHeadWorkouts extends StatelessWidget {
  _buildHead({
    @required BuildContext context,
    @required double burnCalories,
    @required double burnCaloriesTarget,
    @required double steps,
    @required double stepsTarget,
  }) {
    double size = 35;
    double _burnCalories = burnCalories ?? 0;
    double _steps = steps ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 5),
          child: FaIcon(FontAwesomeIcons.dumbbell, color: Colors.grey[700]),
        ),
        Container(
          height: double.infinity,
          child: Row(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.shoePrints, color: Colors.grey.withOpacity(0.5), size: 20),
                  SizedBox(
                    width: size,
                    height: size,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_steps.toStringAsFixed(0), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size,
                    height: size,
                    child: CircularProgressIndicator(
                      value: _steps / stepsTarget,
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
                  FaIcon(FontAwesomeIcons.gripfire, color: Colors.grey.withOpacity(0.5), size: 25),
                  SizedBox(
                    width: size,
                    height: size,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_burnCalories.toStringAsFixed(0), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size,
                    height: size,
                    child: CircularProgressIndicator(
                      value: _burnCalories / burnCaloriesTarget,
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
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final preference = watch(providerPreference).data.value;
      final measurement = watch(providerMeasurement);
      final app = watch(providerAppViewModel);
      double _burnCalories;
      double _steps;

      return measurement.when(
        data: (data) {
          List _list = data.where((element) {
            if (element.dateTime == app.chosenDate && element.dataType == EnumMeasurement.BURN_CALORIES) {
              _burnCalories = element.data.values.first.roundToDouble();
            }

            if (element.dateTime == app.chosenDate && element.dataType == EnumMeasurement.STEPS) {
              _steps = element.data.values.first.roundToDouble();
            }

            return false;
          }).toList();

          return TileExpansion(
            onPressed: null,
            // onPressed: () => Navigator.of(context).pushNamed(
            //   AppRoute.searchScreen,
            //   arguments: SearchScreenArguments(favoriteScreen: FavoriteScreen.workouts, title: Constants.favorites()),
            // ),
            head: _buildHead(
                context: context,
                burnCalories: _burnCalories,
                burnCaloriesTarget: preference.targetBurnCalories,
                steps: _steps,
                stepsTarget: preference.targetSteps),
            listView: CustomListView(
              list: _list,
              type: EnumTileType.measurement,
            ),
          );
        },
        loading: () => Container(),
        error: (err, stack) => Center(child: Text('Error: $err')),
      );
    });
  }
}
