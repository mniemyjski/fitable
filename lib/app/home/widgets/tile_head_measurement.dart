import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/widgets/tile_expansion.dart';
import 'package:fitable/app/measurement/models/measurement_model.dart';
import 'package:fitable/app/measurement/view_models/measurement_view_model.dart';
import 'package:fitable/common_widgets/build_show_dialog.dart';
import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/show_value_picker.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TileHeadMeasurement extends StatelessWidget {
  _buildHead({@required double bodyWeight, @required double bodyWeightTarget, @required double bodyFat, @required double bodyFatTarget}) {
    double size = 35;
    double _weight = bodyWeight > bodyWeightTarget ? (bodyWeightTarget / bodyWeight) : (bodyWeight / bodyWeightTarget);
    double _fat = bodyFat > bodyFatTarget ? (bodyFatTarget / bodyFat) : (bodyFat / bodyFatTarget);

    return Consumer(builder: (context, watch, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5),
            child: FaIcon(FontAwesomeIcons.rulerHorizontal, color: Colors.grey[700]),
          ),
          Container(
            height: double.infinity,
            child: Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.weight, color: Colors.grey.withOpacity(0.5), size: 20),
                    SizedBox(
                      width: size,
                      height: size,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(bodyWeight.toStringAsFixed(1), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size,
                      height: size,
                      child: CircularProgressIndicator(
                        value: _weight,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
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
                      width: size,
                      height: size,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(bodyFat.toStringAsFixed(1), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size,
                      height: size,
                      child: CircularProgressIndicator(
                        value: _fat,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
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
    });
  }

  _show(BuildContext context) {
    buildShowDialog(
        context: context,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                child: Text('add_body_weight'.tr()),
                color: Colors.indigo,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                  showValuePicker(
                      context: context,
                      min: 40,
                      max: 250,
                      initValue: 80,
                      unit: 'kg',
                      function: (double value) =>
                          context.read(providerMeasurementViewModel).submitMeasurement(context, value, 'kg', EnumMeasurement.BODY_WEIGHT));
                }),
            CustomButton(
              child: Text('add_body_fat'.tr()),
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                showValuePicker(
                    context: context,
                    min: 2,
                    max: 30,
                    initValue: 15,
                    unit: '%',
                    isDecimal: true,
                    function: (double value) =>
                        context.read(providerMeasurementViewModel).submitMeasurement(context, value, '%', EnumMeasurement.BODY_FAT));
              },
            ),
            CustomButton(
              child: Text('add_body_muscle'.tr()),
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                showValuePicker(
                    context: context,
                    min: 40,
                    max: 250,
                    initValue: 80,
                    unit: 'kg',
                    function: (double value) =>
                        context.read(providerMeasurementViewModel).submitMeasurement(context, value, 'kg', EnumMeasurement.BODY_MUSCLE));
              },
            ),
            CustomButton(
              child: Text('add_body_circumferences'.tr()),
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(AppRoute.addBodyCircumferencesScreen);
              },
            ),
          ],
        ));
  }

  _onDismissed(BuildContext context, dynamic element) {
    context.read(providerDatabase).deleteMeasurement(element);
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, child) {
      final measurement = watch(providerMeasurement);
      final app = watch(providerAppViewModel);
      final preference = watch(providerPreference).data.value;

      return measurement.when(
        data: (data) {
          List<Measurement> _list = data
              .where((element) =>
                  element.dateTime == app.chosenDate &&
                  (element.dataType == EnumMeasurement.BODY_WEIGHT ||
                      element.dataType == EnumMeasurement.BODY_FAT ||
                      element.dataType == EnumMeasurement.BODY_CIRCUMFERENCES))
              .toList();
          _list.sort((a, b) => a.dateCreation.compareTo(b.dateCreation));

          List<Measurement> _temp = _list;
          _temp = _temp.where((element) => element.dataType == EnumMeasurement.BODY_WEIGHT).toList();
          _temp.sort((a, b) => a.dateCreation.compareTo(b.dateCreation));
          double _bodyWeight = _temp.isNotEmpty ? _temp.first.data.values.first : 0;

          _temp = _list;
          _temp = _temp.where((element) => element.dataType == EnumMeasurement.BODY_FAT).toList();
          _temp.sort((a, b) => a.dateCreation.compareTo(b.dateCreation));

          double _bodyFat = _temp.isNotEmpty ? _temp.first.data.values.first : 0;

          return TileExpansion(
            onPressed: () {
              _show(context);
            },
            head: _buildHead(
                bodyWeight: _bodyWeight, bodyWeightTarget: preference.targetWeight, bodyFat: _bodyFat, bodyFatTarget: preference.targetFat),
            listView: CustomListView(
              list: _list,
              type: EnumTileType.measurement,
              onDismissed: (element) => _onDismissed(context, element),
            ),
          );
        },
        loading: () => Center(
          child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      );
    });
  }
}
