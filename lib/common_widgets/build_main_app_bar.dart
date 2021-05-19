import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

buildMainAppBar({
  @required BuildContext context,
  @required String name,
  bool massage = true,
  bool notifications = true,
  List<Widget> actions,
  PreferredSizeWidget bottom,
}) {
  return AppBar(
    title: Text(name),
    actions: [
      IconButton(
        icon: Icon(FontAwesomeIcons.bell),
        onPressed: () => Navigator.pushNamed(context, AppRoute.notifications),
      ),
      IconButton(
        icon: Icon(FontAwesomeIcons.envelope),
        onPressed: () => Navigator.pushNamed(context, AppRoute.massages),
      ),
      IconButton(
          icon: Icon(FontAwesomeIcons.userFriends),
          onPressed: () => Navigator.of(context).pushNamed(
                AppRoute.searchScreen,
                arguments: SearchScreenArguments(favoriteScreen: TypeFavoriteScreen.accounts, title: Languages.community()),
              )),
      if (actions != null) ...actions,
    ],
    bottom: bottom,
  );
}
