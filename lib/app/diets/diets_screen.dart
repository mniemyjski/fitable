import 'package:fitable/common_widgets/custom_app_bar.dart';
import 'package:fitable/common_widgets/main_drawer.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';

class DietsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(Languages.diets()),
      drawer: MainDrawer(),
      body: Container(),
    );
  }
}
