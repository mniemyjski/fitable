import 'package:fitable/app/meal/models/ingredient_model.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';

class TileProduct extends StatelessWidget {
  final Ingredient element;
  final bool isSuggested;

  const TileProduct({@required this.element, bool this.isSuggested = false});

  @override
  Widget build(BuildContext context) {
    String _name = element.getName();
    String _size = element.getSize().toStringAsFixed(1) + element.getUnit();
    String _calories = '${Languages.kcal()}: ${element.getCalories().toStringAsFixed(0)}';
    String _proteins = '${Languages.p()}: ${element.getProteins().toStringAsFixed(1)}g';
    String _carbs = '${Languages.c()}: ${element.getCarbs().toStringAsFixed(1)}g';
    String _fats = '${Languages.f()}: ${element.getFats().toStringAsFixed(1)}g';
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
                                  child: Text(Languages.suggested(), style: TextStyle(fontSize: 12, color: color, fontStyle: FontStyle.italic)),
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
