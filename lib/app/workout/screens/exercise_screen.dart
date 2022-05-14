import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import 'package:fitable/utilities/utilities.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.exercises),
      drawer: CustomDrawer(),
    );
  }
}
