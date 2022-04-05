import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';
import '../models/product/product_model.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({Key? key}) : super(key: key);

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  Product product = Product.build(dateCreation: DateTime.now(), dateLastUpdate: DateTime.now());

  final GlobalKey<FormState> _formKeyName = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 8),
          CustomTextField(
            formKey: _formKeyName,
            labelText: 'Name',
            onChange: (String s) {
              if (_formKeyName.currentState!.validate()) product = product.copyWith(name: s);
            },
            validator: (v) => v!.length < 8 ? 'test' : null,
            initialValue: 'test',
          ),
          CustomButton(
            onPressed: () {
              if (_formKeyName.currentState!.validate()) Logger().wtf(product);
            },
            child: Text(Strings.save()),
          ),
        ],
      ),
    );
  }
}
