import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/search/widgets/data_search.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/models/meal_model.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreenArguments {
  final SearchType typeSearch;
  final MealType mealType;

  SearchScreenArguments({@required this.typeSearch, this.mealType});
}

enum SearchType { onlyProducts, allFoods, trainings, users }

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
        appBar: AppBar(
          title: Text(Constants.favorites.tr()),
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () async {
                  await showSearch(context: context, delegate: DataSearch());
                }),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.barcode),
                onPressed: () async {
                  String result = await FlutterBarcodeScanner.scanBarcode("#ff6666", "CANCEL", true, ScanMode.BARCODE);

                  if (result != '-1') {
                    final db = context.read(providerDatabase);
                    Product product = await db.getProduct(result);

                    if (product != null) {
                      Navigator.of(context).pushNamed(AppRoute.product, arguments: product);
                    } else {
                      Navigator.of(context).pushNamed(AppRoute.createProduct, arguments: result);
                    }
                  }
                }),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'products'.tr()), Tab(text: 'recipes'.tr()), Tab(text: 'your_recipes'.tr())],
          ),
        ),
        body: TabBarView(children: [
          Container(),
          Container(),
          Container(),
        ]),
      ),
    );
  }
}
