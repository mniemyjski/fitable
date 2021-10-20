import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  @required String title,
  @required String content,
  List<Widget> actions,
  bool onlyOk = false,
}) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions != null
            ? actions
            : <Widget>[
                if (!onlyOk)
                  CupertinoDialogAction(
                    child: Text(Languages.cancel()),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                CupertinoDialogAction(
                  child: Text(Languages.ok()),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
      ),
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions != null
            ? actions
            : <Widget>[
                if (!onlyOk)
                  TextButton(
                    child: Text(Languages.cancel()),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                TextButton(
                  child: Text(Languages.ok()),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
      ),
    );
  }
}
