import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:fitable/widgets/custom_flash_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utilities/utilities.dart';
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
            text: AppLocalizations.of(context)!.home,
            onTap: () => context.router.push(const HomeRoute()),
          ),
          Item(
            icon: Icons.settings,
            text: AppLocalizations.of(context)!.recipes,
            onTap: () => context.router.push(const RecipesRoute()),
          ),
          Item(
            icon: Icons.settings,
            text: AppLocalizations.of(context)!.diets,
            onTap: () {
              context.router.push(const DietsRoute());
            },
          ),
          Item(
            icon: Icons.settings,
            text: AppLocalizations.of(context)!.workouts,
            onTap: () => context.router.push(const WorkoutsRoute()),
          ),
          Item(
            icon: Icons.settings,
            text: AppLocalizations.of(context)!.exercises,
            onTap: () => context.router.push(const ExerciseRoute()),
          ),
          Divider(),
          Item(
            icon: FontAwesomeIcons.question,
            text: AppLocalizations.of(context)!.help,
            onTap: () => context.router.push(const IntroRoute()),
          ),
          Item(
            icon: Icons.settings,
            text: AppLocalizations.of(context)!.settings,
            onTap: () => context.router.push(const SettingsRoute()),
          ),
          Item(
            icon: Icons.exit_to_app,
            text: AppLocalizations.of(context)!.signOut,
            onTap: () => context.read<AuthBloc>().signOut(),
          ),
          SizedBox(height: 36),
          TextButton(
            onPressed: () => customFlashBar(AppLocalizations.of(context)!.notImplemented),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.deleteAccount,
                    style: TextStyle(color: Colors.red)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
