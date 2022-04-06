import 'package:fitable/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';

class TileUser extends StatelessWidget {
  const TileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomAvatar(
              radius: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Imie i nazwisko',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(onPressed: () => null, icon: Icon(Icons.remove))
        ],
      ),
    );
  }
}
