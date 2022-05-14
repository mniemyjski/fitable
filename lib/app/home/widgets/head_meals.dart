import 'package:flutter/material.dart';

class HeadMeals extends StatelessWidget {
  final String name;
  final int kcal;
  final double proteins;
  final double carbs;
  final double fats;

  const HeadMeals({
    Key? key,
    required this.name,
    required this.kcal,
    required this.proteins,
    required this.carbs,
    required this.fats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Text(name, style: Theme.of(context).textTheme.bodyText1),
        ),
        SizedBox(height: 5),
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                  Text('kcal:', style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(width: 2),
                  Text(kcal.toString(), style: Theme.of(context).textTheme.bodyText1),
                ])),
            Expanded(
                flex: 1,
                child: Row(children: <Widget>[
                  Text('p:', style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(width: 2),
                  Text('${proteins.toStringAsFixed(1)}g',
                      style: Theme.of(context).textTheme.bodyText1),
                ])),
            Expanded(
                flex: 1,
                child: Row(children: <Widget>[
                  Text('c:', style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(width: 2),
                  Text('${carbs.toStringAsFixed(1)}g',
                      style: Theme.of(context).textTheme.bodyText1),
                ])),
            Expanded(
                flex: 1,
                child: Row(children: <Widget>[
                  Text('f:', style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(width: 2),
                  Text('${fats.toStringAsFixed(1)}g', style: Theme.of(context).textTheme.bodyText1),
                ])),
          ],
        ),
      ],
    );
  }
}
