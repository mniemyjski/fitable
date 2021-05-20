import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/home/view_models/home_view_model.dart';
import 'package:fitable/services/health_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

chooserDate(int value) {
  return Consumer(builder: (context, watch, child) {
    final app = watch(providerAppViewModel);

    if (value != 0) {
      return Expanded(
          child: Container(
              height: 50,
              child: FlatButton(
                onPressed: () {
                  app.chosenDateIncrementDecrement(value);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(DateFormat('yyyy-MM-dd').format(app.chosenDate.add(new Duration(days: value))),
                        style: TextStyle(color: Theme.of(context).textTheme.headline1.color)),
                    Text(app.dateName(app.chosenDate.add(new Duration(days: value))).tr(),
                        style: TextStyle(color: Theme.of(context).textTheme.headline1.color)),
                  ],
                ),
              )));
    } else {
      return Expanded(
          child: Container(
              height: 50,
              child: FlatButton(
                onPressed: () {
                  showDatePicker(
                          context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(DateTime.now().year + 5))
                      .then((date) {
                    if (date != null) {
                      app.chosenDateSet(date);
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(DateFormat('yyyy-MM-dd').format(app.chosenDate),
                        style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                    Text(app.dateName(app.chosenDate).tr(), style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                  ],
                ),
              )));
    }
  });
}
