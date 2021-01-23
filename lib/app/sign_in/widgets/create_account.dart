import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/sign_in/view_model/create_account_view_model.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/show_input_picker.dart';
import 'package:fitable/common_widgets/show_value_picker.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateAccount extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final model = watch(providerCreateAccountViewModel);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () async {
                final auth = context.read(providerAuthBase);
                try {
                  await auth.signOut();
                } catch (e) {}
              })),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomInputBar(
                name: Constants.name,
                value: model.name,
                onPressed: () {
                  //TODO create function set name in model with validate (non empty and unique)
                  String _value;

                  showInputPicker(
                    context: context,
                    labelText: Constants.name,
                    initValue: model?.name ?? "",
                    onPressed: () {
                      model.name = _value;
                      Navigator.pop(context);
                    },
                    onChanged: (String v) {
                      _value = v;
                    },
                  );
                },
              ),
              SizedBox(height: 4.0),
              CustomInputBar(
                name: Constants.date_birth,
                value: model?.dateBirth != null ? DateFormat('y-MM-dd').format(model.dateBirth) : "",
                onPressed: () {
                  showDatePicker(
                          context: context, initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime(DateTime.now().year + 5))
                      .then((date) {
                    if (date != null) {
                      model.dateBirth = DateTime(date.year, date.month, date.day);
                    }
                  });
                },
              ),
              SizedBox(height: 4.0),
              CustomInputBar(
                name: Constants.height,
                value: model.height?.toStringAsFixed(0) ?? "",
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 40,
                      max: 230,
                      initValue: model?.height ?? 180,
                      unit: 'cm',
                      isDecimal: false,
                      function: (double value) {
                        model.height = value;
                        Navigator.pop(context);
                      });
                },
              ),
              SizedBox(height: 4.0),
              CustomDropDownButton(
                name: Constants.gender.tr(),
                value: model.gender,
                list: <String>["male", "female"],
                onChanged: (v) {
                  model.gender = v;
                },
              ),
              SizedBox(height: 4.0),
              CustomDropDownButton(
                name: Constants.daytime_activities.tr(),
                value: model.dayTimeActivities,
                list: <String>['very_low', 'low', 'normal', 'medium', 'high'],
                onChanged: (v) {
                  model.dayTimeActivities = v;
                },
              ),
              SizedBox(height: 10.0),
              CustomInputBar(
                name: Constants.weight,
                value: model.weight?.toString() ?? "",
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 40,
                      max: 250,
                      initValue: model?.weight ?? 80,
                      unit: 'kg',
                      function: (double value) {
                        model.weight = value;

                        Navigator.pop(context);
                      });
                },
              ),
              SizedBox(height: 4.0),
              CustomInputBar(
                name: Constants.target_weight,
                value: model.targetWeight?.toStringAsFixed(0) ?? "",
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 40,
                      max: 200,
                      initValue: model?.targetWeight ?? 80,
                      unit: 'kg',
                      isDecimal: false,
                      function: (double value) {
                        model.targetWeight = value;

                        Navigator.pop(context);
                      });
                },
              ),
              SizedBox(height: 4.0),
              CustomInputBar(
                name: Constants.target_fat,
                value: model.targetFat?.toStringAsFixed(0) ?? "",
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 2,
                      max: 30,
                      initValue: model?.targetFat ?? 15,
                      unit: '%',
                      isDecimal: false,
                      function: (double value) {
                        model.targetFat = value;

                        Navigator.pop(context);
                      });
                },
              ),
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
                child: RaisedButton(
                    color: Colors.teal[700],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Text(Constants.save.tr()),
                    onPressed: () {
                      final db = context.read(providerDatabase);
                      final auth = context.read(providerAuthState);

                      Preference b = Preference(
                        uid: auth.data.value.uid,
                        healthSync: false,
                        autoPlay: false,
                        mute: true,
                        localeApp: 'pl_PL',
                        localeBase: 'pl_PL',
                        formulaBMR: 'standard',
                        speedChangeWeight: 0.5,
                        lastBodyWeightValue: model.weight,
                        lastBodyWeightDate: DateTime.now(),
                        lastBodyMuscleValue: null,
                        lastBodyMuscleDate: DateTime.now(),
                        lastBodyFatValue: model.fat,
                        lastBodyFatDate: DateTime.now(),
                        dayTimeActivities: model.dayTimeActivities,
                        targetWeight: model.targetWeight,
                        targetFat: model.targetFat,
                        targetSteps: 10000,
                        targetBurnCalories: 2200,
                        goalCaloriesDefault: true,
                        goalMacroDefault: true,
                        goalCalories: null,
                        goalProteins: 30.0,
                        goalCarbs: 50.0,
                        goalFats: 20.0,
                        products: [],
                        recipes: [],
                        exercises: [],
                        trainings: [],
                      );
                      db.createPreference(b);

                      Account a = Account(
                        uid: auth.data.value.uid,
                        name: model.name,
                        gender: model.gender,
                        height: model.height,
                        dateBirth: model.dateBirth,
                        accessStats: AccessLevel.private,
                        accessDateBirth: AccessLevel.private,
                        accessGender: AccessLevel.private,
                        accessHeight: AccessLevel.private,
                        accessMeals: AccessLevel.private,
                        accessMeasurement: AccessLevel.private,
                        bio: '',
                        youtube: '',
                        photosUrl: [],
                        email: '',
                        facebook: '',
                        instagram: '',
                        avatarUrl: auth.data.value.photoURL,
                      );
                      db.createAccount(a);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
