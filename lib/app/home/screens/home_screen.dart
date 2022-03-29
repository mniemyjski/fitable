import 'package:fitable/app/home/widgets/date_chooser.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(title: Strings.home()),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            DateChooser(),
          ],
        ),
        bottomSheet: Expanded(
          child: Container(
            height: 80,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
