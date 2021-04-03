import 'package:fitable/app/community/view_models/community_view_model.dart';
import 'package:fitable/app/search/search_screen.dart';
import 'package:fitable/common_widgets/build_main_app_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/custom_tab_bar.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enum.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerCommunityViewModel);

      return CustomScaffold(
        appBar: buildMainAppBar(
          context: context,
          name: Constants.community(),
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.userFriends),
                onPressed: () => Navigator.of(context).pushNamed(
                      AppRoute.searchScreen,
                      arguments: SearchScreenArguments(searchType: SearchType.users),
                    )),
          ],
        ),
        drawer: MainDrawer(),
        body: Container(),
      );
    });
  }
}
