import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:fitable/constants/strings.dart';
import 'package:fitable/widgets/custom_flash_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/header.dart';
import 'widgets/item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Header(),
          Item(
            icon: Icons.home,
            text: Strings.home(),
            onTap: () => context.router.push(const HomeRoute()),
          ),
          Item(
            icon: Icons.settings,
            text: Strings.settings(),
            onTap: () {
              context.router.push(const SettingsRoute());
            },
          ),
          Divider(),
          Item(
            icon: FontAwesomeIcons.question,
            text: Strings.help(),
            onTap: () {
              // Navigator.of(context).pushNamed(IntroScreen.routeName);
            },
          ),
          Item(
            icon: Icons.exit_to_app,
            text: Strings.sign_out(),
            onTap: () => context.read<AuthBloc>().signOut(),
          ),
          SizedBox(height: 36),
          TextButton(
            onPressed: () => customFlashBar(Strings.not_implemented()),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(Strings.delete_account(), style: TextStyle(color: Colors.red)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}