import 'package:fitable/app/account/view_model/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

buildChooserDate(int value) {
  return Consumer(builder: (context, watch, child) {
    final model = watch(providerAppModel);

    if (value != 0) {
      return Expanded(
          child: Container(
              height: 50,
              child: FlatButton(
                onPressed: () {
                  model.chosenDateIncrement();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(DateFormat('yyyy-MM-dd').format(model.chosenDate.add(new Duration(days: value))),
                        style: TextStyle(color: Theme.of(context).textTheme.headline1.color)),
                    Text(model.dateName(model.chosenDate.add(new Duration(days: 1))).tr(),
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
                      model.chosenDateSet(date);
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(DateFormat('yyyy-MM-dd').format(model.chosenDate),
                        style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                    Text(model.dateName(model.chosenDate).tr(), style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                  ],
                ),
              )));
    }
  });
}
