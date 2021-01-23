import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/view_models/measurement_view_model.dart';
import 'package:fitable/app/home/widgets/tile_expansion.dart';
import 'package:fitable/app/home/widgets/tile_measurement.dart';
import 'package:fitable/common_widgets/build_show_dialog.dart';
import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/common_widgets/show_value_picker.dart';
import 'package:fitable/models/measurement_model.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TileHeadMeasurement extends StatelessWidget {
  _buildListView({@required BuildContext context, @required List list}) {
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
          final Measurement element = list.elementAt(index);

          return GestureDetector(
            onTap: () {},
            child: Dismissible(
                key: Key(key),
                onDismissed: (direction) => context.read(providerDatabase).deleteMeasurement(element),
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
                  child: TileMeasurement(measurement: element),
                )),
          );
        },
      ),
    );
  }

  _buildHead() {
    return Consumer(builder: (context, watch, child) {
      double size = 35;

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
                          Text('', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size,
                      height: size,
                      child: CircularProgressIndicator(
                        value: 0.5,
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
                          Text('', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size,
                      height: size,
                      child: CircularProgressIndicator(
                        value: 0.5,
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

  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, child) {
      final measurement = watch(providerMeasurement);
      final app = watch(providerAppViewModel);

      return measurement.when(
        data: (data) {
          List _list = data.where((element) => element.dateTime == app.chosenDate).toList();

          return TileExpansion(
            onPressed: () {
              _show(context);
            },
            head: _buildHead(),
            listView: _buildListView(context: context, list: _list),
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
