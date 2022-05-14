import 'package:auto_route/auto_route.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:flutter/material.dart';

import '../../../utilities/utilities.dart';

class ElementMeal extends StatelessWidget {
  final TextStyle? style;
  const ElementMeal({Key? key, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(FoodRoute(title: 'Food name')),
      child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText('Name'),
                _buildText('100g'),
                Row(
                  children: [
                    Expanded(child: _buildText('${AppLocalizations.of(context)!.kcal}: 0')),
                    Expanded(child: _buildText('${AppLocalizations.of(context)!.p}: 0.0g')),
                    Expanded(child: _buildText('${AppLocalizations.of(context)!.c}: 0.0g')),
                    Expanded(child: _buildText('${AppLocalizations.of(context)!.f}: 0.0g')),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Builder _buildText(String text) {
    return Builder(builder: (context) {
      return Text(
        text,
        style: style ?? Theme.of(context).textTheme.bodyText1,
      );
    });
  }
}
