import 'package:fitable/constants/strings.dart';
import 'package:fitable/widgets/custom_app_bar.dart';
import 'package:fitable/widgets/custom_drawer/custom_drawer.dart';
import 'package:fitable/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: Strings.home()),
      drawer: CustomDrawer(),
      body: Column(
        children: [],
      ),
    );
  }
}
