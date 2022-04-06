import 'package:fitable/app/massages/widgets/tile_massage.dart';
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
      body: ListView(
        children: [
          SizedBox(height: 8),
          TileMassage(),
          TileMassage(),
          TileMassage(),
        ],
      ),
    );
  }
}
