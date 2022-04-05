import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class NutritionalBasicValue extends StatelessWidget {
  const NutritionalBasicValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 70,
        child: Row(
          children: [
            _buildChart(name: Strings.calories()),
            _buildChart(name: Strings.proteins()),
            _buildChart(name: Strings.carbs()),
            _buildChart(name: Strings.fats()),
          ],
        ),
      ),
    );
  }

  Expanded _buildChart({required String name}) {
    return Expanded(
      child: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('0',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 8,
                          )),
                      Text('0',
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 8,
                              decoration: TextDecoration.overline)),
                    ],
                  ),
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    value: 0.8,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    backgroundColor: Colors.grey[400],
                    strokeWidth: 5,
                  ),
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    value: 0.6,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    strokeWidth: 5,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
