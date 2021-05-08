import 'package:fitable/common_widgets/build_main_app_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';

class WorkoutsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: buildMainAppBar(context: context, name: Languages.workouts()),
      drawer: MainDrawer(),
      body: Container(),
    );
  }
}
