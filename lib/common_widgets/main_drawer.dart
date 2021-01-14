import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/services/providers.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          _createDrawerItem(
            icon: Icons.home,
            text: Constants.home.tr(),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (_) => false);
            },
          ),
          Divider(),
          _createDrawerItem(
              icon: FontAwesomeIcons.utensils,
              text: Constants.diets.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, DietsScreen.route, (_) => false);
              }),
          _createDrawerItem(
              icon: Icons.fastfood,
              text: Constants.recipes.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, RecipeScreen.route, (_) => false);
              }),
          _createDrawerItem(
              icon: FontAwesomeIcons.dumbbell,
              text: Constants.trainings.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, TrainingsScreen.route, (_) => false);
              }),
          Divider(),
          // _createDrawerItem(
          //     icon: Icons.account_box,
          //     text: 'profile'.tr(),
          //     onTap: () {
          //       Navigator.pushNamedAndRemoveUntil(context, ProfileMyScreen.route, (_) => false);
          //     }),
          _createDrawerItem(
              icon: FontAwesomeIcons.users,
              text: Constants.community.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, CommunityScreen.route, (_) => false);
              }),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: Constants.board.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, BoardScreen.route, (_) => false);
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.stars,
              text: Constants.goals.tr(),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.goalsScreen, (_) => false);
              }),
          // _createDrawerItem(
          //     icon: FontAwesomeIcons.chartPie,
          //     text: Constants.statistics.tr(),
          //     onTap: () {
          //       // Navigator.pushNamedAndRemoveUntil(context, StatsScreen.route, (_) => false);
          //     }),
          Divider(),
          _createDrawerItem(
              icon: Icons.settings,
              text: Constants.settings.tr(),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.settingsScreen, (_) => false);
              }),
          _createDrawerItem(
            icon: Icons.exit_to_app,
            text: Constants.sign_out.tr(),
            onTap: () async {
              final auth = context.read(providerAuthBase);
              try {
                await auth.signOut();
              } catch (e) {}
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final account = watch(providerAccount).data.value;

      return DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoute.myAccountScreen, (_) => false);
            },
            child: Stack(children: <Widget>[
              Positioned(
                bottom: 40.0,
                left: 16.0,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black12,
                  child: CachedNetworkImage(
                    imageUrl: account?.avatarUrl ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.account_circle, size: 80),
                  ),
                ),
              ),
              Positioned(
                  bottom: 8.0,
                  left: 16.0,
                  child: Text(
                    account?.name ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                  )),
            ]),
          ));
    });
  }

  Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
