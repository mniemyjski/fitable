import 'package:auto_route/auto_route.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:fitable/app/home/cubit/create_product/create_product_cubit.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/widgets.dart';
import '../models/product/product_model.dart';
import '../widgets/text_field_with_title.dart';

class ProductCreateScreen extends StatefulWidget {
  final Product? product;

  const ProductCreateScreen({Key? key, this.product}) : super(key: key);

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final GlobalKey<FormState> _formKeyName = GlobalKey();
  final GlobalKey<FormState> _formKeyCalories = GlobalKey();
  final GlobalKey<FormState> _formKeyProteins = GlobalKey();
  final GlobalKey<FormState> _formKeyCarbs = GlobalKey();
  final GlobalKey<FormState> _formKeyCarbsNet = GlobalKey();
  final GlobalKey<FormState> _formKeyFats = GlobalKey();

  final GlobalKey<FormState> _formKeySugar = GlobalKey();
  final GlobalKey<FormState> _formKeyAnimalProteins = GlobalKey();
  final GlobalKey<FormState> _formKeyPlantProteins = GlobalKey();
  final GlobalKey<FormState> _formKeySaturated = GlobalKey();
  final GlobalKey<FormState> _formKeyUnsaturated = GlobalKey();
  final GlobalKey<FormState> _formKeyOmega3 = GlobalKey();
  final GlobalKey<FormState> _formKeyOmega6 = GlobalKey();
  final GlobalKey<FormState> _formKeyFiber = GlobalKey();
  final GlobalKey<FormState> _formKeyCaffeine = GlobalKey();
  final GlobalKey<FormState> _formKeyCholesterol = GlobalKey();
  final GlobalKey<FormState> _formKeySalt = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminA = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminC = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminD = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminE = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminK = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB1 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB2 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB3 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB5 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB6 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB7 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB9 = GlobalKey();
  final GlobalKey<FormState> _formKeyVitaminB12 = GlobalKey();
  final GlobalKey<FormState> _formKeyPotassium = GlobalKey();
  final GlobalKey<FormState> _formKeySodium = GlobalKey();
  final GlobalKey<FormState> _formKeyCalcium = GlobalKey();
  final GlobalKey<FormState> _formKeyMagnesium = GlobalKey();
  final GlobalKey<FormState> _formKeyPhosphorus = GlobalKey();
  final GlobalKey<FormState> _formKeyIron = GlobalKey();
  final GlobalKey<FormState> _formKeyCopper = GlobalKey();
  final GlobalKey<FormState> _formKeyZinc = GlobalKey();
  final GlobalKey<FormState> _formKeySelenium = GlobalKey();
  final GlobalKey<FormState> _formKeyManganese = GlobalKey();
  final GlobalKey<FormState> _formKeyIodine = GlobalKey();
  final GlobalKey<FormState> _formKeyChromium = GlobalKey();

  final TextEditingController _categoryPrimaryController = TextEditingController();
  final TextEditingController _categorySecondaryController = TextEditingController();
  final TextEditingController _categoryLocalBase = TextEditingController();

  final List<String> _listOfCities = [
    'test 1',
    'test 2',
    'test 3',
    'test 4',
    'test 5',
    'test 6',
    'test 7',
    'test 8',
    'test 9',
  ];

  @override
  void initState() {
    _categoryPrimaryController.text = '';
    _categorySecondaryController.text = '';
    _categoryLocalBase.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _categoryPrimaryController.dispose();
    _categorySecondaryController.dispose();
    _categoryLocalBase.dispose();

    super.dispose();
  }

  List<SelectedListItem> _buildListSelectedItem(List<String> list) {
    List<SelectedListItem> _listSelectedItem = [];

    list.forEach((element) {
      _listSelectedItem.add(
        SelectedListItem(false, element),
      );
    });

    return _listSelectedItem;
  }

  Builder _buildMainPage(Product product) {
    return Builder(builder: (context) {
      return ListView(
        children: [
          SizedBox(height: 8),
          TextFieldWithTitle(
              formKey: _formKeyName,
              validator: (v) => v!.length < 8 ? 'test' : null,
              title: AppLocalizations.of(context)!.name,
              onChange: (String s) {
                if (_formKeyName.currentState!.validate()) product = product.copyWith(name: s);
              },
              initialValue: 'test'),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text('${AppLocalizations.of(context)!.categoryPrimary}:',
                style: Theme.of(context).textTheme.bodyText2),
          ),
          CustomButtonTextField(
            onPressed: () {
              TextEditingController _searchController = TextEditingController();
              DropDownState(
                DropDown(
                  searchHintText: AppLocalizations.of(context)!.search,
                  searchBackgroundColor: Colors.black12,
                  dataList: _buildListSelectedItem(_listOfCities),
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
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text('${AppLocalizations.of(context)!.categorySecondary}:',
                style: Theme.of(context).textTheme.bodyText2),
          ),
          CustomButtonTextField(
            onPressed: () {
              TextEditingController _searchController = TextEditingController();
              DropDownState(
                DropDown(
                  searchHintText: AppLocalizations.of(context)!.search,
                  searchBackgroundColor: Colors.black12,
                  dataList: _buildListSelectedItem(_listOfCities),
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
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text('${AppLocalizations.of(context)!.localeBase}:',
                style: Theme.of(context).textTheme.bodyText2),
          ),
          CustomButtonTextField(
            onPressed: () {
              TextEditingController _searchController = TextEditingController();
              DropDownState(
                DropDown(
                  searchHintText: AppLocalizations.of(context)!.search,
                  searchBackgroundColor: Colors.black12,
                  dataList: _buildListSelectedItem(_listOfCities),
                  selectedItem: (String selected) {
                    setState(() => _categoryLocalBase.text = selected);
                  },
                  enableMultipleSelection: false,
                  searchController: _searchController,
                ),
              ).showModal(context);
            },
            child: Text(_categoryLocalBase.text, style: Theme.of(context).textTheme.bodyText2),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              '${AppLocalizations.of(context)!.key_words}:',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    children: _keyWordsText(context) ?? [Container()],
                  ),
                ),
                Card(
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    height: 60,
                    width: 60,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () => _onTapKeywords(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          TextFieldWithTitle(
            title: AppLocalizations.of(context)!.calories,
            formKey: _formKeyCalories,
            onChange: (String s) {
              if (_formKeyCalories.currentState!.validate()) product = product.copyWith(name: s);
            },
            validator: (v) {
              if (v == null) return 'wrong';
              if (!isFloat(v)) return 'wrong';
            },
            initialValue: '0.0',
          ),
          Row(
            children: [
              Expanded(
                child: TextFieldWithTitle(
                  title: AppLocalizations.of(context)!.proteins,
                  formKey: _formKeyProteins,
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
              ),
              Expanded(
                child: TextFieldWithTitle(
                  title: AppLocalizations.of(context)!.carbs,
                  formKey: _formKeyCarbs,
                  onChange: (String s) {
                    if (_formKeyCarbs.currentState!.validate()) product = product.copyWith(name: s);
                  },
                  validator: (v) {
                    if (v == null) return 'wrong';
                    if (!isFloat(v)) return 'wrong';
                  },
                  initialValue: '0.0',
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: TextFieldWithTitle(
                  title: AppLocalizations.of(context)!.fats,
                  formKey: _formKeyFats,
                  onChange: (String s) {
                    if (_formKeyFats.currentState!.validate()) product = product.copyWith(name: s);
                  },
                  validator: (v) {
                    if (v == null) return 'wrong';
                    if (!isFloat(v)) return 'wrong';
                  },
                  initialValue: '0.0',
                ),
              ),
            ],
          ),
          TextFieldWithTitle(
            title: AppLocalizations.of(context)!.carbsNet,
            formKey: _formKeyCarbsNet,
            onChange: (String s) {
              if (_formKeyCarbsNet.currentState!.validate()) product = product.copyWith(name: s);
            },
            validator: (v) {
              if (v == null) return 'wrong';
              if (!isFloat(v)) return 'wrong';
            },
            initialValue: '0.0',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              '${AppLocalizations.of(context)!.portions}:',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: GestureDetector(
              onTap: () => context.router.push(const PortionsRoute()),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: 3,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        'test',
                        style: Theme.of(context).textTheme.bodyText1,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          ExpansionTile(
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            tilePadding: EdgeInsets.only(left: 4, right: 8),
            childrenPadding: EdgeInsets.all(0),
            title: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${AppLocalizations.of(context)!.nutritionalValues}:',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWithTitle(
                title: AppLocalizations.of(context)!.sugar,
                formKey: _formKeySugar,
                onChange: (String s) {
                  if (_formKeySugar.currentState!.validate()) product = product.copyWith(name: s);
                },
                validator: (v) {
                  if (v == null) return 'wrong';
                  if (!isFloat(v)) return 'wrong';
                },
                initialValue: '0.0',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 24, bottom: 8),
                child: Text(
                  '${AppLocalizations.of(context)!.proteins}:',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.animalProteins,
                      formKey: _formKeyAnimalProteins,
                      onChange: (String s) {
                        if (_formKeyAnimalProteins.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.plantProteins,
                      formKey: _formKeyPlantProteins,
                      onChange: (String s) {
                        if (_formKeyPlantProteins.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 24, bottom: 8),
                child: Text(
                  '${AppLocalizations.of(context)!.fats}:',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.saturated,
                      formKey: _formKeySaturated,
                      onChange: (String s) {
                        if (_formKeySaturated.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.unsaturated,
                      formKey: _formKeyUnsaturated,
                      onChange: (String s) {
                        if (_formKeyUnsaturated.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.omega3,
                      formKey: _formKeyOmega3,
                      onChange: (String s) {
                        if (_formKeyOmega3.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.omega6,
                      formKey: _formKeyOmega6,
                      onChange: (String s) {
                        if (_formKeyOmega6.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 24, bottom: 8),
                child: Text(
                  '${AppLocalizations.of(context)!.other}:',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.fiber,
                      formKey: _formKeyFiber,
                      onChange: (String s) {
                        if (_formKeyFiber.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.caffeine,
                      formKey: _formKeyCaffeine,
                      onChange: (String s) {
                        if (_formKeyCaffeine.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.cholesterol,
                      formKey: _formKeyCholesterol,
                      onChange: (String s) {
                        if (_formKeyCholesterol.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.salt,
                      formKey: _formKeySalt,
                      onChange: (String s) {
                        if (_formKeySalt.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
            ],
          ),
          ExpansionTile(
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            tilePadding: EdgeInsets.only(left: 4, right: 8),
            childrenPadding: EdgeInsets.all(0),
            title: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${AppLocalizations.of(context)!.vitamins}:',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWithTitle(
                title: AppLocalizations.of(context)!.vitaminA,
                formKey: _formKeyVitaminA,
                onChange: (String s) {
                  if (_formKeyVitaminA.currentState!.validate())
                    product = product.copyWith(name: s);
                },
                validator: (v) {
                  if (v == null) return 'wrong';
                  if (!isFloat(v)) return 'wrong';
                },
                initialValue: '0.0',
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminC,
                      formKey: _formKeyVitaminC,
                      onChange: (String s) {
                        if (_formKeyVitaminC.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminD,
                      formKey: _formKeyVitaminD,
                      onChange: (String s) {
                        if (_formKeyVitaminD.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminE,
                      formKey: _formKeyVitaminE,
                      onChange: (String s) {
                        if (_formKeyVitaminE.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminK,
                      formKey: _formKeyVitaminK,
                      onChange: (String s) {
                        if (_formKeyVitaminK.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminB1,
                      formKey: _formKeyVitaminB1,
                      onChange: (String s) {
                        if (_formKeyVitaminB1.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminB2,
                      formKey: _formKeyVitaminB2,
                      onChange: (String s) {
                        if (_formKeyVitaminB2.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminB3,
                      formKey: _formKeyVitaminB3,
                      onChange: (String s) {
                        if (_formKeyVitaminB3.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminB5,
                      formKey: _formKeyVitaminB5,
                      onChange: (String s) {
                        if (_formKeyVitaminB5.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminB6,
                      formKey: _formKeyVitaminB6,
                      onChange: (String s) {
                        if (_formKeyVitaminB6.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminB7,
                      formKey: _formKeyVitaminB7,
                      onChange: (String s) {
                        if (_formKeyVitaminB7.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminB9,
                      formKey: _formKeyVitaminB9,
                      onChange: (String s) {
                        if (_formKeyVitaminB9.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.vitaminB12,
                      formKey: _formKeyVitaminB12,
                      onChange: (String s) {
                        if (_formKeyVitaminB12.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
            ],
          ),
          ExpansionTile(
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            tilePadding: EdgeInsets.only(left: 4, right: 8),
            childrenPadding: EdgeInsets.all(0),
            title: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${AppLocalizations.of(context)!.macro}:',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.potassium,
                      formKey: _formKeyPotassium,
                      onChange: (String s) {
                        if (_formKeyPotassium.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.sodium,
                      formKey: _formKeySodium,
                      onChange: (String s) {
                        if (_formKeySodium.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.calcium,
                      formKey: _formKeyCalcium,
                      onChange: (String s) {
                        if (_formKeyCalcium.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.magnesium,
                      formKey: _formKeyMagnesium,
                      onChange: (String s) {
                        if (_formKeyMagnesium.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.phosphorus,
                      formKey: _formKeyPhosphorus,
                      onChange: (String s) {
                        if (_formKeyPhosphorus.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
            ],
          ),
          ExpansionTile(
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            tilePadding: EdgeInsets.only(left: 4, right: 8),
            childrenPadding: EdgeInsets.all(0),
            title: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${AppLocalizations.of(context)!.micro}:',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWithTitle(
                title: AppLocalizations.of(context)!.iron,
                formKey: _formKeyIron,
                onChange: (String s) {
                  if (_formKeyIron.currentState!.validate()) product = product.copyWith(name: s);
                },
                validator: (v) {
                  if (v == null) return 'wrong';
                  if (!isFloat(v)) return 'wrong';
                },
                initialValue: '0.0',
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.copper,
                      formKey: _formKeyCopper,
                      onChange: (String s) {
                        if (_formKeyCopper.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.zinc,
                      formKey: _formKeyZinc,
                      onChange: (String s) {
                        if (_formKeyZinc.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.selenium,
                      formKey: _formKeySelenium,
                      onChange: (String s) {
                        if (_formKeySelenium.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.manganese,
                      formKey: _formKeyManganese,
                      onChange: (String s) {
                        if (_formKeyManganese.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.iodine,
                      formKey: _formKeyIodine,
                      onChange: (String s) {
                        if (_formKeyIodine.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: AppLocalizations.of(context)!.chromium,
                      formKey: _formKeyChromium,
                      onChange: (String s) {
                        if (_formKeyChromium.currentState!.validate())
                          product = product.copyWith(name: s);
                      },
                      validator: (v) {
                        if (v == null) return 'wrong';
                        if (!isFloat(v)) return 'wrong';
                      },
                      initialValue: '0.0',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 264,
          )
        ],
      );
    });
  }

  _onTapKeywords(BuildContext context) {
    context.read<CreateProductCubit>().state.whenOrNull(
      loaded: (product) async {
        var _list = await context.router.push(KeyWordsRoute(list: product.keyWords));

        context.read<CreateProductCubit>().builder(
              product.copyWith(keyWords: _list as List<String>),
            );
      },
    );
  }

  List<Widget>? _keyWordsText(BuildContext context) {
    return context.watch<CreateProductCubit>().state.whenOrNull(loaded: (product) {
      return product.keyWords
          .map((e) => Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )))
          .toList();
    });
  }

  _save() {
    if (_formKeyName.currentState!.validate()) {
      context.read<CreateProductCubit>().create();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateProductCubit()..init(product: widget.product),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Product'),
          actions: [
            IconButton(
              onPressed: () => _save(),
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: BlocBuilder<CreateProductCubit, CreateProductState>(
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () => Center(child: CustomLoadingWidget()),
                loaded: (product) => _buildMainPage(product));
          },
        ),
      ),
    );
  }
}
