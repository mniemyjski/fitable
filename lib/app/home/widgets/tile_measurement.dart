import 'package:fitable/constants/constants.dart';
import 'package:fitable/models/measurement_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TileMeasurement extends StatelessWidget {
  final Measurement measurement;

  const TileMeasurement({Key key, @required this.measurement}) : super(key: key);

  List<Widget> _buildName(BuildContext context) {
    if (measurement.dataType == EnumMeasurement.BODY_CIRCUMFERENCES) {
      List<Widget> list = [];

      for (int i = 0; i < measurement.value.length; i++) {
        list.add(RichText(
            text: TextSpan(
          text: measurement.value.keys.toList().elementAt(i).toString(),
          style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic),
        )));
      }

      return list;
    } else {
      return [
        RichText(
            text: TextSpan(
          text: Measurement.toText(measurement.dataType).tr(),
          style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic),
        )),
      ];
    }
  }

  List<Widget> _buildValue(BuildContext context) {
    if (measurement.dataType == EnumMeasurement.BODY_CIRCUMFERENCES) {
      List<Widget> list = [];

      for (int i = 0; i < measurement.value.length; i++) {
        list.add(
          RichText(
              text: TextSpan(
            text: "${measurement.value.values.elementAt(i)}${measurement.unit}",
            style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic),
          )),
        );
      }

      return list;
    } else {
      return [
        RichText(
            text: TextSpan(
          text: "${measurement.value.values.first}${measurement.unit}",
          style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic),
        )),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(minHeight: 35),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    measurement.source == "IMPORT" ? Icons.sync : Icons.create,
                    color: Theme.of(context).textTheme.bodyText2.color,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  RichText(
                      text: TextSpan(
                    text: "${measurement.dateCreation.hour}:${measurement.dateCreation.second}",
                    style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyText2.color, fontStyle: FontStyle.italic),
                  )),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildName(context),
                  ),
                ],
              ),
              Column(
                children: _buildValue(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
