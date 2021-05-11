import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';

class MassagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Languages.massages())),
        body: Center(
          child: Image.asset("resources/images/work_in_progress.jpg"),
        ));
  }
}
