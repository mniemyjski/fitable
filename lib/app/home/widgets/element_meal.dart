import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ElementMeal extends StatelessWidget {
  const ElementMeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 2),
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
                  Expanded(child: _buildText('${Strings.kcal()}: 0')),
                  Expanded(child: _buildText('${Strings.p()}: 0.0g')),
                  Expanded(child: _buildText('${Strings.c()}: 0.0g')),
                  Expanded(child: _buildText('${Strings.f()}: 0.0g')),
                ],
              )
            ],
          ),
        ));
  }

  Builder _buildText(String text) {
    return Builder(builder: (context) {
      return Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
      );
    });
  }
}
