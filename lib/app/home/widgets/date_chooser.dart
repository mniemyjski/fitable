import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/constants.dart';
import '../../../utilities/utilities.dart';

class DateChooser extends StatelessWidget {
  const DateChooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: Row(
        children: [
          _dateButton(dateTime: DateTime.now().add(Duration(days: -1)), onTap: () => null),
          Container(width: 1, height: double.infinity, color: Colors.black12),
          _dateButton(dateTime: DateTime.now(), onTap: () => _showPickerDate(context)),
          Container(width: 1, height: double.infinity, color: Colors.black12),
          _dateButton(dateTime: DateTime.now().add(Duration(days: 1)), onTap: () => null),
        ],
      ),
    );
  }

  _showPickerDate(BuildContext context) {
    return Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(),
        title: Text("Select Data"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
        }).showDialog(context);
  }

  Builder _dateButton({required DateTime dateTime, required GestureTapCallback onTap}) {
    return Builder(builder: (context) {
      return Expanded(
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('yyyy-MM-dd').format(dateTime).toString(),
                  style: Theme.of(context).textTheme.bodyText2),
              Text(_nameDate(dateTime, context), style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ),
      );
    });
  }

  String _nameDate(DateTime dateTime, BuildContext context) {
    dateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
    DateTime dateTimeNow = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    if (dateTime == dateTimeNow) {
      return AppLocalizations.of(context)!.today;
    } else if (dateTime == dateTimeNow.add(Duration(days: 1))) {
      return AppLocalizations.of(context)!.tomorrow;
    } else if (dateTime == dateTimeNow.add(Duration(days: -1))) {
      return AppLocalizations.of(context)!.yesterday;
    } else if (dateTime.weekday == 1) {
      return AppLocalizations.of(context)!.monday;
    } else if (dateTime.weekday == 2) {
      return AppLocalizations.of(context)!.tuesday;
    } else if (dateTime.weekday == 3) {
      return AppLocalizations.of(context)!.wednesday;
    } else if (dateTime.weekday == 4) {
      return AppLocalizations.of(context)!.thursday;
    } else if (dateTime.weekday == 5) {
      return AppLocalizations.of(context)!.friday;
    } else if (dateTime.weekday == 6) {
      return AppLocalizations.of(context)!.saturday;
    } else if (dateTime.weekday == 7) {
      return AppLocalizations.of(context)!.sunday;
    } else {
      return '';
    }
  }
}
