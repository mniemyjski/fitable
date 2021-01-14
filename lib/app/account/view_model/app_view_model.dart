import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAppModel = ChangeNotifierProvider<AppModel>((ref) {
  return AppModel();
});

class AppModel extends ChangeNotifier {
  bool darkMode = false;
  Color colorPrimary = Colors.lightBlue[700];
  Color colorSecondary = Colors.lightGreen[700];
  Color colorCards = Colors.white;
  Color colorBackground = Colors.grey[200];

  DateTime _chosenDate = DateTime.now();

  DateTime get chosenDate => _chosenDate;

  void chosenDateSet(DateTime value) {
    _chosenDate = value;
    notifyListeners();
  }

  void chosenDateIncrementDecrement(int value) {
    _chosenDate = _chosenDate.add(new Duration(days: value));
    notifyListeners();
  }

  void darkModeSet(bool value) {
    darkMode = value;
    if (value) {
    } else {}
    notifyListeners();
  }

  String dateName(DateTime chosenDate) {
    DateTime dateTimeNow;

    chosenDate = DateTime(chosenDate.year, chosenDate.month, chosenDate.day);
    dateTimeNow = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (chosenDate == dateTimeNow) {
      return 'today';
    } else if (chosenDate == dateTimeNow.add(new Duration(days: 1))) {
      return 'tomorrow';
    } else if (chosenDate == dateTimeNow.add(new Duration(days: -1))) {
      return 'yesterday';
    } else if (chosenDate.weekday == 1) {
      return 'monday';
    } else if (chosenDate.weekday == 2) {
      return 'tuesday';
    } else if (chosenDate.weekday == 3) {
      return 'wednesday';
    } else if (chosenDate.weekday == 4) {
      return 'thursday';
    } else if (chosenDate.weekday == 5) {
      return 'friday';
    } else if (chosenDate.weekday == 6) {
      return 'saturday';
    } else if (chosenDate.weekday == 7) {
      return 'sunday';
    } else {
      return '';
    }
  }
}
