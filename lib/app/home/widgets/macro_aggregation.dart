import 'package:fitable/app/home/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class MacroAggregation extends StatelessWidget {
  final int calories;
  final double proteins;
  final double carbs;
  final double fats;
  final double caloriesTarget;
  final double proteinsTarget;
  final double carbsTarget;
  final double fatsTarget;

  const MacroAggregation({
    Key key,
    @required this.calories,
    @required this.proteins,
    @required this.carbs,
    @required this.fats,
    @required this.caloriesTarget,
    @required this.proteinsTarget,
    @required this.carbsTarget,
    @required this.fatsTarget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        margin: EdgeInsets.only(top: 5, bottom: 5),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ProgressBar(
                mainBar: true,
                name: 'calories',
                value: 0,
                valueTotal: double.tryParse(calories.toString()),
                valueTarget: caloriesTarget,
                proteins: proteins,
                carbs: carbs,
                fats: fats,
                colorVolume: Colors.blue[700],
                colorTotal: Colors.lightBlue),
            ProgressBar(
                mainBar: false,
                name: 'proteins',
                value: 0,
                valueTotal: proteins,
                valueTarget: proteinsTarget,
                proteins: proteins,
                carbs: carbs,
                fats: fats,
                colorVolume: Colors.green[700],
                colorTotal: Colors.lightGreen),
            ProgressBar(
                mainBar: false,
                name: 'carbs',
                value: 0,
                valueTotal: carbs,
                valueTarget: carbsTarget,
                proteins: proteins,
                carbs: carbs,
                fats: fats,
                colorVolume: Colors.orange[700],
                colorTotal: Colors.orangeAccent),
            ProgressBar(
                mainBar: false,
                name: 'fats',
                value: 0,
                valueTotal: fats,
                valueTarget: fatsTarget,
                proteins: proteins,
                carbs: carbs,
                fats: fats,
                colorVolume: Colors.red[700],
                colorTotal: Colors.redAccent),
          ],
        ));
  }
}
