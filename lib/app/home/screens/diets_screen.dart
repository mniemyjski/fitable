import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';

class DietsScreen extends StatelessWidget {
  const DietsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: Strings.diets()),
      drawer: CustomDrawer(),
      body: Container(),
    );
  }
}
