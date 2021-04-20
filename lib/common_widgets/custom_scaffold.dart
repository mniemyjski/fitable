import 'package:fitable/app/account/models/preference_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget appBar;
  final Widget drawer;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  const CustomScaffold({
    Key key,
    this.body,
    this.appBar,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      Preference preference;
      watch(providerPreference).whenData((value) => preference = value);

      return Scaffold(
        drawer: drawer,
        appBar: appBar,
        backgroundColor: (preference?.darkMode ?? false) ? null : Colors.grey[200],
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      );
    });
  }
}
