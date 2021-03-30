import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/common_widgets/build_main_app_bar.dart';
import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/common_widgets/show_value_picker.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoalsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final preference = watch(providerPreference);
    final db = watch(providerDatabase);
    final app = watch(providerAppViewModel);

    String activitiesDescription(String value) {
      switch (value) {
        case 'very_low':
          return Constants.no_activities_description();
        case 'low':
          return Constants.low_activities_description();
        case 'normal':
          return Constants.normal_activities_description();
        case 'medium':
          return Constants.medium_activities_description();
        case 'high':
          return Constants.high_activities_description();
        default:
          return null;
      }
    }

    String formulaDescription(String value) {
      switch (value) {
        case 'standard':
          return Constants.formula_standard_description();
        case 'advanced':
          return Constants.formula_advance_description();
        default:
          return null;
      }
    }

    String _calculate(BuildContext context) {
      final pref = context.read(providerPreference).data.value;
      final model = context.read(providerHomeViewModel);
      model.calculateBMR(context: context);

      String _calories = pref.goalCaloriesDefault ? model.goalCalories.toStringAsFixed(0) : pref.goalCalories.toStringAsFixed(0);
      String _proteins = pref.goalProteins.toStringAsFixed(0);
      String _carbs = pref.goalCarbs.toStringAsFixed(0);
      String _fats = pref.goalFats.toStringAsFixed(0);

      return Constants.calories() +
          ': ' +
          _calories +
          ', ' +
          Constants.p() +
          ': ' +
          _proteins +
          '%, ' +
          Constants.c() +
          ': ' +
          _carbs +
          '%, ' +
          Constants.f() +
          ': ' +
          _fats +
          '%';
    }

    _buildBody(Preference preference) {
      return CustomScaffold(
          appBar: buildMainAppBar(context, Constants.goals()),
          drawer: MainDrawer(),
          body: Column(
            children: [
              Card(
                child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      'Zmiana dla ${DateFormat('y-MM-dd').format(app.chosenDate)} oraz nowych.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ))),
              ),
              CustomDropDownButton(
                name: Constants.daytime_activities(),
                value: preference.dayTimeActivities,
                description: true,
                descFunc: activitiesDescription,
                list: <String>['very_low', 'low', 'normal', 'medium', 'high'],
                onChanged: (v) {
                  db.updatePreference(name: 'dayTimeActivities', value: v);
                },
              ),
              CustomDropDownButton(
                name: Constants.formula_bmr(),
                value: preference.formulaBMR,
                description: true,
                descFunc: formulaDescription,
                list: <String>['standard', 'advanced'],
                onChanged: (v) {
                  //TODO validator sprawdzający czy jest dodany poziom tkanki tłuszczowej
                  db.updatePreference(name: 'formulaBMR', value: v);
                },
              ),
              CustomInputBar(
                name: Constants.speed_change_weight(),
                value: preference.speedChangeWeight.toStringAsFixed(1),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        double _speedChangeWeight = preference.speedChangeWeight;

                        return StatefulBuilder(builder: (context, setState) {
                          return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(bottom: 40),
                                        child: Text(
                                          (_speedChangeWeight).toStringAsFixed(1) + ' kg',
                                          style: TextStyle(fontSize: 20, color: Colors.grey[700], fontWeight: FontWeight.bold),
                                        )),
                                    Slider(
                                      min: 0,
                                      max: 100,
                                      divisions: 20,
                                      value: _speedChangeWeight * 100,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _speedChangeWeight = newValue / 100;
                                        });
                                      },
                                    ),
                                    CustomButton(
                                        color: Colors.indigo,
                                        child: Text(
                                          'save'.tr(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          db.updatePreference(name: 'speedChangeWeight', value: _speedChangeWeight);
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      });
                },
              ),
              CustomInputBar(
                name: Constants.target_weight(),
                value: preference.targetWeight.toStringAsFixed(0),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 40,
                      max: 200,
                      initValue: preference.targetWeight,
                      unit: 'kg',
                      isDecimal: false,
                      function: (double value) {
                        db.updatePreference(name: 'targetWeight', value: value);
                        Navigator.pop(context);
                      });
                },
              ),
              CustomInputBar(
                name: Constants.target_fat(),
                value: "${preference.targetFat.toStringAsFixed(0)}%",
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 2,
                      max: 30,
                      initValue: preference.targetFat,
                      unit: '%',
                      isDecimal: false,
                      function: (double value) {
                        db.updatePreference(name: 'targetFat', value: value);
                        Navigator.pop(context);
                      });
                },
              ),
              CustomInputBar(
                name: Constants.target_steps(),
                value: preference.targetSteps.toStringAsFixed(0),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 1,
                      max: 200,
                      addition: 500,
                      initValue: preference.targetSteps,
                      unit: '',
                      isDecimal: false,
                      function: (double value) {
                        db.updatePreference(name: 'targetSteps', value: value);
                        Navigator.pop(context);
                      });
                },
              ),
              CustomInputBar(
                name: Constants.target_burn_calories(),
                value: preference.targetBurnCalories.toStringAsFixed(0),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 19,
                      max: 200,
                      addition: 50,
                      initValue: preference.targetBurnCalories,
                      unit: '',
                      isDecimal: false,
                      function: (double value) {
                        db.updatePreference(name: 'targetBurnCalories', value: value);
                        Navigator.pop(context);
                      });
                },
              ),
              CustomInputBar(
                name: Constants.macro(),
                value: _calculate(context),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoute.goalsMacroScreen);
                },
              ),
            ],
          ));
    }

    return preference.when(
      data: (preference) => _buildBody(preference),
      loading: () => Scaffold(
        body: Center(
          child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
