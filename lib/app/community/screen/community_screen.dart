import 'package:fitable/app/community/widgets/tile_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/custom_search_delegate.dart';
import 'package:fitable/utilities/utilities.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.community),
          actions: [
            IconButton(
              onPressed: () => showSearch(context: context, delegate: CustomSearchDelegate()),
              icon: FaIcon(Icons.search),
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: AppLocalizations.of(context)!.followers,
              ),
              Tab(
                text: AppLocalizations.of(context)!.following,
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 8),
            TileUser(),
            TileUser(),
            TileUser(),
          ],
        ),
      ),
    );
  }
}
