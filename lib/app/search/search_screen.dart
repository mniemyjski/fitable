import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/widgets/build_actions_buttons.dart';
import 'package:fitable/app/account/widgets/build_floating_action_button.dart';
import 'package:fitable/app/account/widgets/build_tab.dart';
import 'package:fitable/app/account/widgets/build_tab_bar_view.dart';
import 'package:fitable/models/favorite_model.dart';
import 'package:fitable/models/meal_model.dart';
import 'package:fitable/app/search/view_models/search_view_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/custom_tab_bar.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/database.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreenArguments {
  final TypeFavoriteScreen favoriteScreen;
  final String title;

  SearchScreenArguments({@required this.favoriteScreen, @required this.title});
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

    model.favoriteScreen = args.favoriteScreen;
    model.title = args.title;
    buildTab(model);

    model.controller = TabController(length: model.tabBar.length, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerSearchViewModel);

      model.controller.addListener(() {
        setState(() {
          model.selectedIndex = model.controller.index;
        });
      });

      return Scaffold(
          appBar: AppBar(
            title: Text(model.title),
            actions: buildActionButtons(context, model.mobilePlatform(), model.favoriteScreen),
            bottom: CustomTabBar(
              color: Theme.of(context).primaryColor,
              tabBar: TabBar(
                controller: model.controller,
                indicatorColor: Colors.white,
                tabs: model.tabBar,
              ),
            ),
          ),
          body: Consumer(builder: (context, watch, child) {
            final favorites = watch(providerFavorite);
            final db = watch(providerDatabase);

            return favorites.when(
              data: (data) => TabBarView(
                  controller: model.controller,
                  children: buildTabBarView(
                    context: context,
                    db: db,
                    favorites: data,
                    favoriteScreen: model.favoriteScreen,
                  )),
              loading: () => Center(child: Container(height: 100, width: 100, child: CircularProgressIndicator())),
              error: (err, stack) => Center(child: Text(Languages.error())),
            );
          }),
          floatingActionButton: buildFloatingActionButton(context));
    });
  }
}
