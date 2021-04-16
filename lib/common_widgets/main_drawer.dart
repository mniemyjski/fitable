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
            text: Constants.home(),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (_) => false);
            },
          ),
          // _createDrawerItem(
          //     icon: FontAwesomeIcons.users,
          //     text: Constants.community(),
          //     // inactive: true,
          //     onTap: () {
          //       Navigator.pushNamedAndRemoveUntil(context, AppRoute.communityScreen, (_) => false);
          //     }),
          Divider(),
          _createDrawerItem(
              icon: FontAwesomeIcons.utensils,
              text: Constants.diets(),
              inactive: true,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.dietsScreen, (_) => false);
              }),
          _createDrawerItem(
              icon: Icons.fastfood,
              text: Constants.recipes(),
              // inactive: true,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.recipeScreen, (_) => false);
              }),
          // _createDrawerItem(
          //     icon: FontAwesomeIcons.dumbbell,
          //     text: Constants.workouts(),
          //     inactive: true,
          //     onTap: () {
          //       Navigator.pushNamedAndRemoveUntil(context, AppRoute.workoutsScreen, (_) => false);
          //     }),
          Divider(),
          _createDrawerItem(
              icon: Icons.stars,
              text: Constants.goals(),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.goalsScreen, (_) => false);
              }),
          // _createDrawerItem(
          //     icon: FontAwesomeIcons.chartPie,
          //     text: Constants.statistics(),
          //     inactive: true,
          //     onTap: () {
          //       Navigator.pushNamedAndRemoveUntil(context, AppRoute.statistics, (_) => false);
          //     }),
          Divider(),
          _createDrawerItem(
              icon: Icons.settings,
              text: Constants.settings(),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.settingsScreen, (_) => false);
              }),
          _createDrawerItem(
            icon: Icons.exit_to_app,
            text: Constants.sign_out(),
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
                  radius: 55,
                  backgroundColor: Colors.black12,
                  child: CachedNetworkImage(
                    imageUrl: account?.avatarUrl ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.account_circle,
                      size: 110,
                      color: Colors.white,
                    ),
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

  Widget _createDrawerItem({@required IconData icon, @required String text, @required GestureTapCallback onTap, bool inactive = false}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text, style: inactive ? TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey) : null),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
