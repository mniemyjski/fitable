import 'package:fitable/common_widgets/custom_input_bar.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class AddBodyCircumferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomInputBar(name: null, value: null, onTap: null),
        ],
      ),
    );
  }
}
