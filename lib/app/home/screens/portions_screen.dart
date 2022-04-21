import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/material.dart';

class PortionsScreen extends StatelessWidget {
  const PortionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.portions),
      ),
      body: Container(),
    );
  }
}
