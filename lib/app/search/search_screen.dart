import 'package:fitable/app/home/models/favorite_model.dart';
import 'package:fitable/app/product/create_product_screen.dart';
import 'package:fitable/app/product/food_screen.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/product/widget/tile_product.dart';
import 'package:fitable/app/search/widgets/data_search.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchType { onlyProducts, allFoods, trainings, users }

class SearchScreenArguments {
  final SearchType typeSearch;
  final MealType mealType;

  SearchScreenArguments({@required this.typeSearch, @required this.mealType});
}

_buildListView({@required BuildContext context, @required List list}) {
  return Container(
    child: ListView.separated(
      separatorBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: 75),
          child: Divider(
            height: 5,
            color: Colors.grey,
          )),
      itemCount: list.length,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, int index) {
        // final key = list.elementAt(index).productID;
        final element = list.elementAt(index);

        return GestureDetector(
          onTap: () {},
          child: Dismissible(
              key: Key(index.toString()),
              onDismissed: (direction) => null,
              direction: DismissDirection.startToEnd,
              background: Container(
                height: double.infinity,
                child: Container(
                    height: double.infinity,
                    alignment: Alignment.centerLeft,
                    color: Colors.red[600],
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    )),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 90),
                child: TileProduct(product: element),
              )),
        );
      },
    ),
  );
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
        appBar: AppBar(
          title: Text(Constants.favorites.tr()),
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () async {
                  // FacebookAudienceNetwork.init(
                  //   testingId: "1fc63a78-68f9-4ac1-8faa-6d3688d610aa", //optional
                  // );
                  //
                  // FacebookInterstitialAd.loadInterstitialAd(
                  //   placementId: "1366934306833619_1366944173499299",
                  //   listener: (effect, value) {
                  //     if (effect == InterstitialAdResult.LOADED) FacebookInterstitialAd.showInterstitialAd(delay: 5000);
                  //   },
                  // );

                  dynamic value = await showSearch(context: context, delegate: DataSearch());

                  if (value != null) {
                    Navigator.of(context).pushNamed(AppRoute.foodScreen,
                        arguments: FoodScreenArguments(
                          product: value,
                          mealType: args.mealType,
                        ));
                  }
                }),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.barcode),
                onPressed: () async {
                  String result = await FlutterBarcodeScanner.scanBarcode("#ff6666", "CANCEL", true, ScanMode.BARCODE);

                  if (result != '-1') {
                    final db = context.read(providerDatabase);
                    Product product = await db.getProduct(result);

                    if (product != null) {
                      Navigator.of(context).pushNamed(AppRoute.foodScreen,
                          arguments: FoodScreenArguments(
                            product: product,
                            mealType: args.mealType,
                          ));
                    } else {
                      Navigator.of(context).pushNamed(AppRoute.createProductScreen,
                          arguments: CreateProductScreenArguments(
                            barcode: result,
                            mealType: args.mealType,
                          ));
                    }
                  }
                }),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'products'.tr()), Tab(text: 'recipes'.tr()), Tab(text: 'your_recipes'.tr())],
          ),
        ),
        body: Consumer(builder: (context, watch, child) {
          final favorites = watch(providerFavorite);
          final db = watch(providerDatabase);

          return favorites.when(
            data: (data) => TabBarView(children: [
              StreamBuilder<List<Product>>(
                  stream: db.streamProducts(data),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) return CircularProgressIndicator();
                    if (snapshot.hasData) return _buildListView(context: context, list: snapshot.data);
                    return Container();
                  }),
              Container(),
              Container(),
            ]),
            loading: () => Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator())),
            error: (err, stack) => Center(child: Text('Error: $err')),
          );
        }),
      ),
    );
  }
}
