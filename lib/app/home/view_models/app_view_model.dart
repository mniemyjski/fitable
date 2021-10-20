import 'package:fitable/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAppViewModel = ChangeNotifierProvider<AppViewModel>((ref) {
  return AppViewModel();
});

class AppViewModel extends ChangeNotifier {
  DateTime _chosenDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime get chosenDate => _chosenDate;

  void chosenDateSet(BuildContext context, DateTime value) {
    _chosenDate = DateTime(value.year, value.month, value.day);
    context.read(providerHealthService).getHealthData(chosenDate);
    notifyListeners();
  }

  void chosenDateIncrementDecrement(BuildContext context, int value) {
    DateTime _v = _chosenDate.add(Duration(days: value));
    _chosenDate = DateTime(_v.year, _v.month, _v.day);
    context.read(providerHealthService).getHealthData(chosenDate);
    notifyListeners();
  }

  String dateName(DateTime chosenDate) {
    DateTime dateTimeNow;

    chosenDate = DateTime(chosenDate.year, chosenDate.month, chosenDate.day);
    dateTimeNow = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (chosenDate == dateTimeNow) {
      return 'today';
    } else if (chosenDate == dateTimeNow.add(Duration(days: 1))) {
      return 'tomorrow';
    } else if (chosenDate == dateTimeNow.add(Duration(days: -1))) {
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
