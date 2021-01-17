import 'package:flutter/material.dart';

buildShowDialog({
  @required BuildContext context,
  @required Widget child,
  double height = 300,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), //this right here
            child: Container(
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: child,
              ),
            ),
          );
        });
      });
}
