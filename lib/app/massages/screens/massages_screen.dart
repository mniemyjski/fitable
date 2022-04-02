import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class MassagesScreen extends StatelessWidget {
  const MassagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.massages()),
      ),
    );
  }
}
