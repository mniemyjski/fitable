import 'package:flutter/material.dart';

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Container(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(),
          )),
        ],
      ),
    ),
  );
}
