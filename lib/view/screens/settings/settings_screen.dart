import 'package:fitable/services/auth.dart';
import 'package:fitable/view/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const route = '/SettingsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      drawer: MainDrawer(),
      body: Container(),
    );
  }
}
