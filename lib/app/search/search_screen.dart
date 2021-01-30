import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/database.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchType { onlyProducts, allFoods, trainings, users }

class SearchScreenArguments {
  final SearchType typeSearch;
  final MealType mealType;

  SearchScreenArguments({@required this.typeSearch, @required this.mealType});
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  _buildFloatingActionButton() {
    final model = context.read(providerSearchViewModel);

    if (model.selectedIndex == 2) {
      return FloatingActionButton(
        onPressed: () {
          model.selectedIndex = model.controller.index = 0;
          return Navigator.pushNamed(context, AppRoute.recipeCreateScreen);
        },
        child: Icon(Icons.add, color: Colors.white),
      );
    } else {
      return null;
    }
  }

  @override
  void didChangeDependencies() {
    final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
    final model = context.read(providerSearchViewModel);
    switch (args.typeSearch) {
      case SearchType.onlyProducts:
        model.list = [
          Tab(text: 'products'.tr()),
        ];
        break;
      case SearchType.allFoods:
        model.list = [
          Tab(text: 'products'.tr()),
          Tab(text: 'recipes'.tr()),
          Tab(text: 'your_recipes'.tr()),
        ];
        break;
      case SearchType.trainings:
        model.list = [];
        break;
      case SearchType.users:
        model.list = [];
        break;
    }

    model.controller = TabController(length: model.list.length, vsync: this);
    model.controller.addListener(() {
      setState(() {
        model.selectedIndex = model.controller.index;
      });
    });
    super.didChangeDependencies();
  }

  _buildTabBarView(Database db, List<Favorite> favorites, SearchViewModel model) {
    final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;

    return [
      if (args.typeSearch == SearchType.onlyProducts || args.typeSearch == SearchType.allFoods)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<Product>>(
              stream: db.streamProducts(favorites),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomListView(
                    list: snapshot.data,
                    type: EnumTileType.product,
                    direction: DismissDirection.none,
                    onPressed: (element) => model.onPressed(context, element),
                  );
                }
                return Container();
              }),
        ),
      if (args.typeSearch == SearchType.allFoods) Center(child: Container(child: Text('recipe'.tr()))),
      if (args.typeSearch == SearchType.allFoods) Center(child: Container(child: Text('your_recipe'.tr()))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerSearchViewModel);

      return CustomScaffold(
          appBar: AppBar(
            title: Text(Constants.favorites.tr()),
            actions: [
              IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: () => model.searchOnPress(context)),
              if (model.mobilePlatform()) IconButton(icon: FaIcon(FontAwesomeIcons.barcode), onPressed: () => model.barcodeOnPress(context)),
            ],
            bottom: TabBar(
              controller: model.controller,
              indicatorColor: Colors.white,
              tabs: model.list,
            ),
          ),
          body: Consumer(builder: (context, watch, child) {
            final favorites = watch(providerFavorite);
            final db = watch(providerDatabase);

            return favorites.when(
              data: (data) => TabBarView(controller: model.controller, children: _buildTabBarView(db, data, model)),
              loading: () => Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator())),
              error: (err, stack) => Center(child: Text('Error: $err')),
            );
          }),
          floatingActionButton: _buildFloatingActionButton());
    });
  }
}
