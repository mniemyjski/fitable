import 'package:drop_down_list/drop_down_list.dart';
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
  final GlobalKey<FormState> _formKeyCalories = GlobalKey();
  final GlobalKey<FormState> _formKeyProteins = GlobalKey();
  final GlobalKey<FormState> _formKeyCarbs = GlobalKey();
  final GlobalKey<FormState> _formKeyFats = GlobalKey();
  final TextEditingController _categoryPrimaryController = TextEditingController();
  final TextEditingController _categorySecondaryController = TextEditingController();

  final List<SelectedListItem> _listOfCities = [
    SelectedListItem(false, 'test 1'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
    SelectedListItem(false, 'test 2'),
  ];

  @override
  void initState() {
    _categoryPrimaryController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKeyName.currentState!.validate()) Logger().wtf(product);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Strings.name()
          _titleTextHead(context, Strings.name(), padding: const EdgeInsets.only(left: 8, top: 8)),
          CustomTextField(
            formKey: _formKeyName,
            labelText: '',
            onChange: (String s) {
              if (_formKeyName.currentState!.validate()) product = product.copyWith(name: s);
            },
            validator: (v) => v!.length < 8 ? 'test' : null,
            initialValue: 'test',
          ),

          // Strings.category_primary()
          _titleTextHead(context, Strings.category_primary()),
          CustomButtonTextField(
            onPressed: () {
              TextEditingController _searchController = TextEditingController();
              DropDownState(
                DropDown(
                  searchHintText: Strings.search(),
                  searchBackgroundColor: Colors.black12,
                  dataList: _listOfCities,
                  selectedItem: (String selected) {
                    setState(() => _categoryPrimaryController.text = selected);
                  },
                  enableMultipleSelection: false,
                  searchController: _searchController,
                ),
              ).showModal(context);
            },
            child:
                Text(_categoryPrimaryController.text, style: Theme.of(context).textTheme.bodyText2),
          ),

          // Strings.category_primary()
          _titleTextHead(context, Strings.category_secondary()),
          CustomButtonTextField(
            onPressed: () {
              TextEditingController _searchController = TextEditingController();
              DropDownState(
                DropDown(
                  searchHintText: Strings.search(),
                  searchBackgroundColor: Colors.black12,
                  dataList: _listOfCities,
                  selectedItem: (String selected) {
                    setState(() => _categorySecondaryController.text = selected);
                  },
                  enableMultipleSelection: false,
                  searchController: _searchController,
                ),
              ).showModal(context);
            },
            child: Text(_categorySecondaryController.text,
                style: Theme.of(context).textTheme.bodyText2),
          ),

          // Strings.locale_base()
          _titleTextHead(context, Strings.locale_base()),
          CustomButtonTextField(
            onPressed: () {
              TextEditingController _searchController = TextEditingController();
              DropDownState(
                DropDown(
                  searchHintText: Strings.search(),
                  searchBackgroundColor: Colors.black12,
                  dataList: _listOfCities,
                  selectedItem: (String selected) {
                    setState(() => _categorySecondaryController.text = selected);
                  },
                  enableMultipleSelection: false,
                  searchController: _searchController,
                ),
              ).showModal(context);
            },
            child: Text(_categorySecondaryController.text,
                style: Theme.of(context).textTheme.bodyText2),
          ),

          // Strings.calories()
          _titleTextHead(context, Strings.calories()),
          CustomTextField(
            formKey: _formKeyCalories,
            labelText: '',
            onChange: (String s) {
              if (_formKeyCalories.currentState!.validate()) product = product.copyWith(name: s);
            },
            validator: (v) {
              if (v == null) return 'wrong';
              if (!isNumeric(v)) return 'wrong';
            },
            initialValue: '0',
          ),

          Row(
            children: [
              //Strings.proteins()
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleTextHead(context, Strings.proteins()),
                    CustomTextField(
                      formKey: _formKeyProteins,
                      labelText: '',
                      onChange: (String s) {
                        if (_formKeyProteins.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ],
                ),
              ),
              //Strings.carbs()
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleTextHead(context, Strings.carbs()),
                    CustomTextField(
                      formKey: _formKeyCarbs,
                      labelText: '',
                      onChange: (String s) {
                        if (_formKeyCarbs.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              //Strings.fats()
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleTextHead(context, Strings.fats()),
                    CustomTextField(
                      // formKey: _formKeyFats,
                      labelText: '',
                      onChange: (String s) {
                        if (_formKeyFats.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ],
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Center(
              child:
                  Text(Strings.nutritional_value(), style: Theme.of(context).textTheme.bodyText2),
            ),
            children: [],
          ),
        ],
      ),
    );
  }

  Padding _titleTextHead(BuildContext context, String name, {EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 8, top: 4),
      child: Text('$name:', style: Theme.of(context).textTheme.bodyText2),
    );
  }
}
