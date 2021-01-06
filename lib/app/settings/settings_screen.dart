import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/models/preference_model.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

bool darkMode = false;

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.settings.tr()),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          final pref = watch(providerPreference);
          final db = watch(providerDatabase);

          return pref.when(
            data: (pref) => Column(
              children: <Widget>[
                CustomDropDownButton(
                    name: Constants.localeApp,
                    value: pref.localeApp,
                    list: <String>['pl_PL', 'en_US'],
                    onChanged: (String state) {
                      setState(() {
                        context.locale = Locale(state.substring(0, state.indexOf('_')), state.substring(state.indexOf('_') + 1, state.length));
                        db.updatePreference(name: Constants.localeApp, value: state);
                      });
                    }),
                CustomDropDownButton(
                    name: Constants.localeBase,
                    value: pref.localeBase,
                    list: <String>['pl_PL'],
                    onChanged: (state) {
                      db.updatePreference(name: Constants.localeBase, value: state);
                    }),
                Container(
                  child: Row(
                    children: <Widget>[
                      Switch(
                          value: pref.healthSync,
                          onChanged: (state) {
                            db.updatePreference(name: Constants.healthSync, value: state);
                          }),
                      Text(Constants.healthSync.tr()),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Switch(
                          value: pref.autoPlay,
                          onChanged: (state) {
                            db.updatePreference(name: Constants.autoPlay, value: state);
                          }),
                      Text(Constants.autoPlay.tr()),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Switch(
                          value: pref.mute,
                          onChanged: (state) {
                            db.updatePreference(name: Constants.mute, value: state);
                          }),
                      Text(Constants.mute.tr()),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Switch(
                          value: darkMode,
                          onChanged: (state) {
                            setState(() {
                              // data.darkModeOn(state);
                            });
                          }),
                      Text(Constants.dark_mode.tr()),
                    ],
                  ),
                ),
              ],
            ),
            loading: () => Container(height: 100, width: 100, child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          );
        }),
      ),
    );
  }
}
