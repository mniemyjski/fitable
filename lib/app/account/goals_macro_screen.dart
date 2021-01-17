import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/all.dart';

class GoalsMacroScreen extends StatefulWidget {
  @override
  _GoalsMacroScreenState createState() => _GoalsMacroScreenState();
}

class _GoalsMacroScreenState extends State<GoalsMacroScreen> {
  TextEditingController caloriesController = TextEditingController();
  TextEditingController proteinsController = TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  String total;

  @override
  void initState() {
    context.read(providerPreference).whenData((preference) {
      final model = context.read(providerHomeViewModel);
      model.calculateBMR(context: context);
      if (preference.goalCaloriesDefault) {
        caloriesController.text = model.goalCalories.toStringAsFixed(0);
      }

      proteinsController.text = preference.goalProteins.toStringAsFixed(0);
      carbsController.text = preference.goalCarbs.toStringAsFixed(0);
      fatsController.text = preference.goalFats.toStringAsFixed(0);

      total = (preference.goalProteins + preference.goalCarbs + preference.goalFats).toStringAsFixed(0);
      super.initState();
    });
  }

  _submit() {
    final db = context.read(providerDatabase);
    context.read(providerPreference).whenData((preference) {
      if (!preference.goalCaloriesDefault) {
        db.updatePreference(name: 'goalCalories', value: double.parse(caloriesController.text));
      }

      if (!preference.goalMacroDefault && int.tryParse(total) == 100) {
        db.updatePreference(name: 'goalProteins', value: double.parse(caloriesController.text));
        db.updatePreference(name: 'goalCarbs', value: double.parse(carbsController.text));
        db.updatePreference(name: 'goalFats', value: double.parse(fatsController.text));
      }
    });
  }

  _calculateTotal() {
    setState(() {
      total = (int.tryParse(proteinsController.text) + int.tryParse(carbsController.text) + int.tryParse(fatsController.text)).toString();
    });
  }

  _switchCalories(bool state, Preference preference) {
    final model = context.read(providerHomeViewModel);
    context.read(providerDatabase).updatePreference(name: 'goalCaloriesDefault', value: state);
    model.calculateBMR(context: context);

    if (!preference.goalCaloriesDefault) {
      setState(() {
        caloriesController.text = model.goalCalories.toStringAsFixed(0);
      });
    }
  }

  _switchMacro(bool state, Preference preference) {
    final model = context.read(providerHomeViewModel);
    context.read(providerDatabase).updatePreference(name: 'goalMacroDefault', value: state);
    model.calculateBMR(context: context);

    if (!preference.goalMacroDefault) {
      setState(() {
        proteinsController.text = '30';
        carbsController.text = '50';
        fatsController.text = '20';
        _calculateTotal();
      });
    }
  }

  _buildBody(BuildContext context, Preference preference) {
    return Column(
      children: [
        Container(
          child: Row(
            children: <Widget>[
              Switch(
                value: preference.goalCaloriesDefault,
                onChanged: (state) => _switchCalories(state, preference),
              ),
              Text('default_calories'.tr()),
            ],
          ),
        ),
        CustomTextField(
          name: 'calories'.tr(),
          enabled: !preference.goalCaloriesDefault,
          controller: caloriesController,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Switch(
                value: preference.goalMacroDefault,
                onChanged: (state) => _switchMacro(state, preference),
              ),
              Text('default_macro'.tr()),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                name: 'proteins'.tr(),
                suffix: "%",
                enabled: !preference.goalMacroDefault,
                controller: proteinsController,
                onChanged: (v) {
                  _calculateTotal();
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'carbs'.tr(),
                suffix: "%",
                enabled: !preference.goalMacroDefault,
                controller: carbsController,
                onChanged: (v) {
                  _calculateTotal();
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                name: 'fats'.tr(),
                suffix: "%",
                enabled: !preference.goalMacroDefault,
                controller: fatsController,
                onChanged: (v) {
                  _calculateTotal();
                },
              ),
            ),
          ],
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('total'.tr()),
                    Text('$total%', style: TextStyle(color: int.tryParse(total) != 100 ? Colors.redAccent : Colors.grey)),
                  ],
                ),
                SizedBox(height: 10),
                Text('total_value_macronutrients_must_be_description'.tr()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final preference = watch(providerPreference);
      return preference.when(
        data: (data) {
          return CustomScaffold(
              appBar: AppBar(
                actions: [IconButton(icon: Icon(Icons.save), onPressed: () => _submit())],
              ),
              body: _buildBody(context, data));
        },
        loading: () => Scaffold(
          body: Center(
            child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
          ),
        ),
        error: (err, stack) => Scaffold(
          body: Center(child: Text('Error: $err')),
        ),
      );
    });
  }
}
