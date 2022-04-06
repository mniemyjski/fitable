import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class TileNotification extends StatelessWidget {
  const TileNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomAvatar(
              radius: 25,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification title',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
