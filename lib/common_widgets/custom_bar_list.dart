import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class CustomBarList extends StatelessWidget {
  final String name;
  final dynamic value;
  final VoidCallback onPressed;

  const CustomBarList({Key key, @required this.name, @required this.value, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name + ":", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(value),
                ],
              ),
            ),
          ),
        ),
        CustomIconButton(onPressed: onPressed),
      ],
    );
  }
}
