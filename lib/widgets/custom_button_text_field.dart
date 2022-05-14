import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButtonTextField extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const CustomButtonTextField({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: new BoxConstraints(maxWidth: 450),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            alignment: Alignment.centerLeft,
            side: BorderSide(color: Colors.white38),
            padding: EdgeInsets.only(left: 11),
            minimumSize: Size(48, 48),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
