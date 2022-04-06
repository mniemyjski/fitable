import 'package:fitable/app/notifications/widgets/tile_notification.dart';
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
      body: ListView(
        children: [
          SizedBox(height: 8),
          TileNotification(),
          TileNotification(),
          TileNotification(),
        ],
      ),
    );
  }
}
