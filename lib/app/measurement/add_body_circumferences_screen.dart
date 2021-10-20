import 'package:fitable/app/measurement/view_models/measurement_view_model.dart';
import 'package:fitable/common_widgets/show_custom_dialog.dart';
import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/show_value_picker.dart';
import 'package:fitable/services/services.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBodyCircumferencesScreen extends ConsumerWidget {
  _submit(BuildContext context) async {
    final String result = context.read(providerMeasurementViewModel).submitCircumferences(context);
    if (result != 'done') showCustomDialog(context: context, child: Center(child: Text(result)));
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final model = watch(providerMeasurementViewModel);

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () => _submit(context))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomInputBar(
                name: 'neck'.tr(),
                value: model.toText(model.neck),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 10,
                      max: 80,
                      initValue: 20,
                      unit: 'cm',
                      isDecimal: true,
                      function: (double value) {
                        model.neck = value;
                        Navigator.pop(context);
                      });
                }),
            CustomInputBar(
                name: 'chest'.tr(),
                value: model.toText(model.chest),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 10,
                      max: 180,
                      initValue: 20,
                      unit: 'cm',
                      isDecimal: true,
                      function: (double value) {
                        model.chest = value;
                        Navigator.pop(context);
                      });
                }),
            CustomInputBar(
                name: 'biceps'.tr(),
                value: model.toText(model.biceps),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 10,
                      max: 80,
                      initValue: 20,
                      unit: 'cm',
                      isDecimal: true,
                      function: (double value) {
                        model.biceps = value;
                        Navigator.pop(context);
                      });
                }),
            CustomInputBar(
                name: 'waist'.tr(),
                value: model.toText(model.waist),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 10,
                      max: 180,
                      initValue: 20,
                      unit: 'cm',
                      isDecimal: true,
                      function: (double value) {
                        model.waist = value;
                        Navigator.pop(context);
                      });
                }),
            CustomInputBar(
                name: 'abdomen'.tr(),
                value: model.toText(model.abdomen),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 10,
                      max: 180,
                      initValue: 20,
                      unit: 'cm',
                      isDecimal: true,
                      function: (double value) {
                        model.abdomen = value;
                        Navigator.pop(context);
                      });
                }),
            CustomInputBar(
                name: 'hips'.tr(),
                value: model.toText(model.hips),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 10,
                      max: 120,
                      initValue: 20,
                      unit: 'cm',
                      isDecimal: true,
                      function: (double value) {
                        model.hips = value;
                        Navigator.pop(context);
                      });
                }),
            CustomInputBar(
                name: 'thigh'.tr(),
                value: model.toText(model.thigh),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 10,
                      max: 150,
                      initValue: 20,
                      unit: 'cm',
                      isDecimal: true,
                      function: (double value) {
                        model.thigh = value;
                        Navigator.pop(context);
                      });
                }),
            CustomInputBar(
                name: 'calf'.tr(),
                value: model.toText(model.calf),
                onPressed: () {
                  showValuePicker(
                      context: context,
                      min: 10,
                      max: 80,
                      initValue: 20,
                      unit: 'cm',
                      isDecimal: true,
                      function: (double value) {
                        model.calf = value;
                        Navigator.pop(context);
                      });
                }),
            Container(
              child: Row(
                children: <Widget>[
                  Switch(
                      value: model.calculate,
                      onChanged: (state) {
                        final account = context.read(providerAccount);
                        account.whenData((value) {
                          model.age = value.getAge();
                          model.gender = value.gender;
                          model.calculate = state;
                        });
                      }),
                  Text('calculate_body_fat'.tr()),
                ],
              ),
            ),
            if (model.calculate)
              Card(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 6, top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("body_fat".tr() + ':', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text(model.bodyFat),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
