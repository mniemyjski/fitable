import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:fitable/services/macro.dart';

class TileProduct extends StatelessWidget {
  final element;
  final isSuggested;

  const TileProduct({@required this.element, bool this.isSuggested = false});

  @override
  Widget build(BuildContext context) {
    String _name = Macro.getName(element);
    String _size = Macro.getSize(element).toStringAsFixed(1) + Macro.getUnit(element);

    String _calories = '${Constants.kcal()}: ${Macro.calculateCalories(
      element,
      Macro.getSize(element),
      Macro.getSelectedPortion(element),
    ).toStringAsFixed(0)}';

    String _proteins = '${Constants.p()}: ${Macro.calculateProteins(
      element,
      Macro.getSize(element),
      Macro.getSelectedPortion(element),
    ).toStringAsFixed(1)}g';

    String _carbs = '${Constants.c()}: ${Macro.calculateCarbs(
      element,
      Macro.getSize(element),
      Macro.getSelectedPortion(element),
    ).toStringAsFixed(1)}g';

    String _fats = '${Constants.f()}: ${Macro.calculateFats(
      element,
      Macro.getSize(element),
      Macro.getSelectedPortion(element),
    ).toStringAsFixed(1)}g';

    String dash = Theme.of(context).brightness == Brightness.light ? "resources/images/dash_2.png" : "resources/images/dash_1.png";
    Color color = isSuggested ? Theme.of(context).textTheme.bodyText2.color.withOpacity(0.2) : Theme.of(context).textTheme.bodyText2.color;

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: isSuggested
                ? BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage(dash),
                    fit: BoxFit.cover,
                  ))
                : BoxDecoration(),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4, left: 2),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 0),
                                child: Text(_name, style: TextStyle(fontSize: 12, color: color, fontStyle: FontStyle.italic)),
                              ),
                            ),
                            Expanded(flex: 1, child: Text('')),
                            if (isSuggested)
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 0),
                                  child: Text(Constants.suggested(), style: TextStyle(fontSize: 12, color: color, fontStyle: FontStyle.italic)),
                                ),
                              ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 0),
                            width: double.infinity,
                            child: Text(_size, style: TextStyle(fontSize: 12, color: color, fontStyle: FontStyle.italic))),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(_calories, style: TextStyle(fontSize: 12, color: color, fontStyle: FontStyle.italic)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(_proteins, style: TextStyle(fontSize: 12, color: color, fontStyle: FontStyle.italic)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(_carbs, style: TextStyle(fontSize: 12, color: color, fontStyle: FontStyle.italic)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(_fats, style: TextStyle(fontSize: 12, color: color, fontStyle: FontStyle.italic)),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
