import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: Strings.exercises()),
      drawer: CustomDrawer(),
    );
  }
}
