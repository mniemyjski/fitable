import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomInputBar extends StatelessWidget {
  final String name;
  final String value;
  final GestureTapCallback onTap;

  const CustomInputBar({Key key, @required this.name, @required this.value, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: double.infinity,
          height: 58,
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name.tr() ?? "", style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(value ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
