import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.notifications()),
      ),
    );
  }
}
