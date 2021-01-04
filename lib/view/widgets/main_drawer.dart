import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/view/screens/home/home_screen.dart';
import 'package:fitable/view/screens/landing/landing_screen.dart';
import 'package:fitable/view/screens/settings/settings_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class MainDrawer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MainDrawer> {
  bool internet = true;

  internetCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          internet = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        internet = false;
      });
    }
  }

  @override
  void initState() {
    internetCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          _createDrawerItem(
            icon: Icons.home,
            text: 'home'.tr(),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.route, (_) => false);
            },
          ),
          Divider(),
          _createDrawerItem(
              icon: FontAwesomeIcons.utensils,
              text: 'diets'.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, DietsScreen.route, (_) => false);
              }),
          _createDrawerItem(
              icon: Icons.fastfood,
              text: 'recipes'.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, RecipeScreen.route, (_) => false);
              }),
          _createDrawerItem(
              icon: FontAwesomeIcons.dumbbell,
              text: 'trainings'.tr(),
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
              text: 'community'.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, CommunityScreen.route, (_) => false);
              }),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: 'board'.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, BoardScreen.route, (_) => false);
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.stars,
              text: 'goals'.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, GoalsScreen.route, (_) => false);
              }),
          _createDrawerItem(
              icon: FontAwesomeIcons.chartPie,
              text: 'statistics'.tr(),
              onTap: () {
                // Navigator.pushNamedAndRemoveUntil(context, StatsScreen.route, (_) => false);
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'settings'.tr(),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, SettingsScreen.route, (_) => false);
              }),
          _createDrawerItem(
            icon: Icons.exit_to_app,
            text: 'sign_out'.tr(),
            onTap: () async {
              final auth = Provider.of<AuthBase>(context, listen: false);
              try {
                await auth.signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              } catch (e) {}
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: GestureDetector(
          onTap: () {
            // Navigator.pushNamedAndRemoveUntil(context, ProfileMyScreen.route, (_) => false);
          },
          child: Stack(children: <Widget>[
            Positioned(
              bottom: 40.0,
              left: 16.0,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black12,
                child: CachedNetworkImage(
                  imageUrl: '',
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.account_circle),
                ),
              ),
            ),
            Positioned(bottom: 8.0, left: 16.0, child: Text('', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500))),
          ]),
        ));
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
