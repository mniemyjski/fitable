import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ProgressBar extends StatelessWidget {
  final bool mainBar;
  final String name;
  final double value;
  final double valueTotal;
  final double valueTarget;
  final double proteins;
  final double carbs;
  final double fats;
  final Color colorVolume;
  final Color colorTotal;

  ProgressBar({
    @required this.mainBar,
    @required this.name,
    @required this.value,
    @required this.valueTotal,
    @required this.valueTarget,
    @required this.proteins,
    @required this.carbs,
    @required this.fats,
    @required this.colorVolume,
    @required this.colorTotal,
  });

  @override
  Widget build(BuildContext context) {
    double _radius1 = 35;
    double _radius2 = 45;

    volumePanel() {
      if (mainBar == true && value != 0) {
        return Column(
          children: <Widget>[
            Text(value.toStringAsFixed(0), style: TextStyle(fontSize: 8, color: Theme.of(context).textTheme.headline2.color)),
          ],
        );
      } else if (value == 0 && mainBar == true) {
        return Column(
          children: <Widget>[
            Text(valueTotal.toStringAsFixed(0), style: TextStyle(fontSize: 8, color: Theme.of(context).textTheme.headline2.color)),
            Text(valueTarget.toStringAsFixed(0),
                style: TextStyle(fontSize: 8, color: Theme.of(context).textTheme.headline2.color, decoration: TextDecoration.overline)),
          ],
        );
      } else if (value == 0 && mainBar == false) {
        return Column(
          children: <Widget>[
            Text(valueTotal.toStringAsFixed(0) + "g", style: TextStyle(fontSize: 8, color: Theme.of(context).textTheme.headline2.color)),
            Text(valueTarget.toStringAsFixed(0) + "g",
                style: TextStyle(fontSize: 8, color: Theme.of(context).textTheme.headline2.color, decoration: TextDecoration.overline)),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            Text(((value / (proteins + carbs + fats)) * 100).toStringAsFixed(0) + '%',
                style: TextStyle(fontSize: 8, color: Theme.of(context).textTheme.headline2.color)),
            Text(value.toStringAsFixed(1) + 'g', style: TextStyle(fontSize: 8, color: Theme.of(context).textTheme.headline2.color)),
          ],
        );
      }
    }

    macroBar(double volume, Color color) {
      if (mainBar == true) {
        return SizedBox(
          width: _radius2,
          height: _radius2,
          child: CircularProgressIndicator(
            value: volume,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 2,
          ),
        );
      } else {
        return Container();
      }
    }

    macroPanel() {
      if (mainBar == true) {
        return Container(
          margin: EdgeInsets.only(left: 3),
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 10),
              Text((proteins > 0 ? ((proteins / (proteins + carbs + fats) * 100)) : 0).toStringAsFixed(0) + "%",
                  style: TextStyle(fontSize: 10, color: Colors.lightGreen, fontWeight: FontWeight.bold)),
              Text((carbs > 0 ? ((carbs / (proteins + carbs + fats) * 100)) : 0).toStringAsFixed(0) + "%",
                  style: TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
              Text((fats > 0 ? ((fats / (proteins + carbs + fats) * 100)) : 0).toStringAsFixed(0) + "%",
                  style: TextStyle(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      } else {
        return Container();
      }
    }

    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: mainBar == true ? 2 : 8),
                child:
                    Text(name.tr(), style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.headline2.color, fontWeight: FontWeight.bold))),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: _radius1,
                  height: _radius1,
                  child: CircularProgressIndicator(
                    value: ((valueTotal + value) / valueTarget),
                    valueColor: AlwaysStoppedAnimation<Color>(colorVolume),
                    backgroundColor: Colors.grey[400],
                    strokeWidth: 5,
                  ),
                ),
                SizedBox(
                  width: _radius1,
                  height: _radius1,
                  child: CircularProgressIndicator(
                    value: valueTotal / valueTarget,
                    valueColor: AlwaysStoppedAnimation<Color>(colorTotal),
                    strokeWidth: 5,
                  ),
                ),
                macroBar(((valueTotal + value) / valueTarget), Colors.redAccent),
                macroBar(((valueTotal + value) / valueTarget) * (proteins > 0 ? ((proteins + carbs) / (proteins + carbs + fats)) : 0),
                    Colors.orangeAccent),
                macroBar(((valueTotal + value) / valueTarget) * (proteins > 0 ? (proteins / (proteins + carbs + fats)) : 0), Colors.lightGreen),
                volumePanel(),
              ],
            ),
          ],
        ),
        macroPanel(),
      ],
    );
  }
}
