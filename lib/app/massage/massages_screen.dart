import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/constants/constants.dart';
import 'package:flutter/material.dart';

class MassagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(title: Text(Constants.massages())),
      body: Container(),
    );
  }
}