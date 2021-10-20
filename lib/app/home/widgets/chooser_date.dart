import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class ChooserDate extends StatelessWidget {
  final int value;
  const ChooserDate(this.value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value != 0) {
      return Expanded(
          child: Container(
              height: 50,
              child: TextButton(
                onPressed: () {
                  context.read((providerAppViewModel)).chosenDateIncrementDecrement(context, value);
                },
                child: Consumer(builder: (context, watch, child) {
                  final app = watch(providerAppViewModel);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(DateFormat('yyyy-MM-dd').format(app.chosenDate.add(new Duration(days: value))),
                          style: TextStyle(color: Theme.of(context).textTheme.headline1.color)),
                      Text(app.dateName(app.chosenDate.add(new Duration(days: value))).tr(),
                          style: TextStyle(color: Theme.of(context).textTheme.headline1.color))
                    ],
                  );
                }),
              )));
    }

    return Expanded(
        child: Container(
            height: 50,
            child: TextButton(
              onPressed: () {
                showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(DateTime.now().year + 5))
                    .then((date) {
                  if (date != null) {
                    context.read((providerAppViewModel)).chosenDateSet(context, date);
                  }
                });
              },
              child: Consumer(builder: (context, watch, child) {
                final app = watch(providerAppViewModel);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(DateFormat('yyyy-MM-dd').format(app.chosenDate),
                        style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                    Text(app.dateName(app.chosenDate).tr(), style: TextStyle(color: Colors.white, decoration: TextDecoration.underline))
                  ],
                );
              }),
            )));
  }
}
