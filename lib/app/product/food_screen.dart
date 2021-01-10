import 'package:fitable/app/home/widgets/macro_aggregation.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/widget/nutritional.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodScreen extends StatelessWidget {
  final Product product;

  const FoodScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _calories = 200;
    double _proteins = 10;
    double _carbs = 10;
    double _fats = 10;
    double _caloriesTarget = 2000;
    double _proteinsTarget = 50;
    double _carbsTarget = 50;
    double _fatsTarget = 50;

    return CustomScaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(FontAwesomeIcons.heart), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Container(
                height: 55,
                width: double.infinity,
                child: Center(child: Text(product.productName)),
              ),
            ),
            Card(
                child: MacroAggregation(
              calories: _calories,
              proteins: _proteins,
              carbs: _carbs,
              fats: _fats,
              caloriesTarget: _caloriesTarget,
              proteinsTarget: _proteinsTarget,
              carbsTarget: _carbsTarget,
              fatsTarget: _fatsTarget,
            )),
            Row(
              children: [
                Container(
                  width: 150,
                  child: CustomTextField(
                    keyboardType: TextInputType.number,
                    hintText: '100',
                    onChanged: (v) {},
                  ),
                ),
                Expanded(child: CustomDropDownButton(name: '', value: 'g', list: <String>['g', 'ml'], onChanged: (v) {}))
              ],
            ),
            FlatButton(
                onPressed: () {},
                child: Text(
                  'bug_report',
                  style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                )),
            nutritional(product: product)
          ],
        ),
      ),
    );
  }
}
