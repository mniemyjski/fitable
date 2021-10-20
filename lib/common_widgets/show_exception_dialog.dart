import 'package:firebase_core/firebase_core.dart';
import 'package:fitable/common_widgets/show_alert_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showExceptionDialog(
  BuildContext context, {
  @required String title,
  @required Exception exception,
}) =>
    showAlertDialog(context, title: title, content: _message(exception), onlyOk: true);

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message;
  }
  return exception.toString();
}
