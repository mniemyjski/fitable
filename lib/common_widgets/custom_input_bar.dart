import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomInputBar extends StatelessWidget {
  final String name;
  final String value;
  final GestureTapCallback onPressed;

  const CustomInputBar({Key key, @required this.name, @required this.value, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 6, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${name.tr()}:", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(value ?? ""),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
