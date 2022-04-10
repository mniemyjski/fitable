import 'package:fitable/app/settings/cubit/dark_mode_cubit.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:fitable/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/locale_cubit.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: customAppBar(title: AppLocalizations.of(context)!.settings),
        drawer: CustomDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: CustomDropDownButton(
                  name: AppLocalizations.of(context)!.localeApp,
                  value: context.watch<LocaleCubit>().state.languageCode,
                  list: <String>['pl', 'en'],
                  onChanged: (String? state) {
                    context.read<LocaleCubit>().change(Enums.toEnum(state!, ETypeLocale.values));
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    BlocBuilder<DarkModeCubit, bool>(
                      builder: (context, state) {
                        return Switch(
                          value: state,
                          onChanged: (state) {
                            context.read<DarkModeCubit>().change();
                          },
                        );
                      },
                    ),
                    Text(
                      AppLocalizations.of(context)!.darkMode,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
