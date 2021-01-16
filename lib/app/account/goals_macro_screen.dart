import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GoalsMacroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: <Widget>[
                Switch(value: false, onChanged: (state) {}),
                Text('default_calories'),
              ],
            ),
          ),
          CustomTextField(
            name: 'calories',
            suffix: "kcal",
            onChanged: (v) {},
          ),
          Container(
            child: Row(
              children: <Widget>[
                Switch(value: false, onChanged: (state) {}),
                Text('default_macro'),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  name: 'calories',
                  suffix: "kcal",
                  onChanged: (v) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'calories',
                  suffix: "kcal",
                  onChanged: (v) {},
                ),
              ),
              Expanded(
                child: CustomTextField(
                  name: 'calories',
                  suffix: "kcal",
                  onChanged: (v) {},
                ),
              ),
            ],
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('total'),
                      Text('%', style: TextStyle(color: 5 > 100 ? Colors.redAccent : Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('total_value_macronutrients_must_be_description'.tr()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
