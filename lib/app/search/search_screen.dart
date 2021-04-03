import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/app/meal/models/meal_model.dart';
import 'package:fitable/app/product/models/product_model.dart';
import 'package:fitable/app/recipe/models/recipe_model.dart';
import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_tab_bar.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enum.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/database.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreenArguments {
  final SearchType searchType;

  SearchScreenArguments({@required this.searchType});
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    final SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
    final model = context.read(providerSearchViewModel);

    model.searchType = args.searchType;

    switch (args.searchType) {
      case SearchType.onlyProducts:
        model.list = [
          Tab(text: Constants.products()),
        ];
        break;
      case SearchType.allFoods:
        model.list = [
          Tab(text: Constants.products()),
          Tab(text: Constants.recipes()),
          Tab(text: Constants.your_recipes()),
        ];
        break;
      case SearchType.workouts:
        model.list = [
          Tab(text: Constants.exercises()),
          Tab(text: Constants.workouts()),
        ];
        break;
      case SearchType.users:
        model.list = [
          Tab(text: Constants.followed()),
          Tab(text: Constants.followers()),
        ];
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

  _buildTabBarView(Database db, List<Favorite> favoritesProduct, List<Favorite> favoritesRecipe, SearchViewModel model) {
    return [
      if (model.searchType == SearchType.onlyProducts || model.searchType == SearchType.allFoods)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<Product>>(
              stream: db.streamProducts(favoritesProduct),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomListView(
                    list: snapshot.data,
                    type: EnumTileType.product,
                    direction: DismissDirection.none,
                    onPressed: (element) => model.productDetails(context, element),
                  );
                }
                return Container();
              }),
        ),
      if (model.searchType == SearchType.allFoods)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<Recipe>>(
              stream: db.streamFavoriteRecipes(favoritesRecipe),
              builder: (context, snapshot) {
                if (snapshot.hasError) Center(child: Text('error'));

                if (snapshot.hasData) {
                  return CustomListView(
                    list: snapshot.data,
                    type: EnumTileType.recipe,
                    direction: DismissDirection.none,
                    onPressed: (element) => model.recipeDetails(context, element),
                  );
                }
                return Container(child: Center(child: Text('Empty')));
              }),
        ),
      if (model.searchType == SearchType.allFoods)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<Recipe>>(
              stream: db.streamYourRecipes(),
              builder: (context, snapshot) {
                if (snapshot.hasError) Center(child: Text('error'));

                if (snapshot.hasData) {
                  return CustomListView(
                    list: snapshot.data,
                    type: EnumTileType.recipe,
                    direction: DismissDirection.none,
                    onPressed: (element) => model.recipeDetails(context, element),
                  );
                }
                return Container(child: Center(child: Text('Empty')));
              }),
        ),
      if (model.searchType == SearchType.users) ...[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Constants.followed()),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Constants.followers()),
          ),
        ),
      ],
      if (model.searchType == SearchType.workouts) ...[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Constants.exercises()),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Constants.workouts()),
          ),
        ),
      ]
    ];
  }

  List<Widget> _actions(bool mobilePlatform, SearchType searchType) {
    return [
      IconButton(
          icon: Icon(FontAwesomeIcons.search, color: Colors.white), onPressed: () => context.read(providerSearchViewModel).searchOnPress(context)),
      if (mobilePlatform && (searchType == SearchType.onlyProducts || searchType == SearchType.allFoods))
        IconButton(icon: FaIcon(FontAwesomeIcons.barcode), onPressed: () => context.read(providerSearchViewModel).barcodeOnPress(context))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerSearchViewModel);

      return CustomScaffold(
          appBar: AppBar(
            title: Text(Constants.favorites()),
            actions: _actions(model.mobilePlatform(), model.searchType),
            bottom: CustomTabBar(
              color: Theme.of(context).primaryColor,
              tabBar: TabBar(
                controller: model.controller,
                indicatorColor: Colors.white,
                tabs: model.list,
              ),
            ),
          ),
          body: Consumer(builder: (context, watch, child) {
            final favorites = watch(providerFavorite);
            final db = watch(providerDatabase);

            return favorites.when(
              data: (data) => TabBarView(controller: model.controller, children: _buildTabBarView(db, data, data, model)),
              loading: () => Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator())),
              error: (err, stack) => Center(child: Text('Error: $err')),
            );
          }),
          floatingActionButton: _buildFloatingActionButton());
    });
  }
}
